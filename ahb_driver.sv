class ahb_driver extends uvm_driver #(ahb_xtn);

        `uvm_component_utils(ahb_driver)
		virtual ahb_if.DRV_MP vif;

        ahb_agt_config ahb_cfg;

        extern function new(string name="ahb_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
	    extern function void connect_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);
		extern task send_to_dut(ahb_xtn xtn);
    	extern function void end_of_elaboration_phase(uvm_phase phase);
endclass

function ahb_driver::new(string name="ahb_driver",uvm_component parent);
        super.new(name,parent);
endfunction


function void ahb_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(ahb_agt_config)::get(this,"","ahb_agt_config",ahb_cfg))
                `uvm_fatal("CONFIG","Cannot get() ahb_agent_config from uvm_config_db. Is it set()?")
endfunction

function void ahb_driver::connect_phase(uvm_phase phase);
        vif=ahb_cfg.vif;
endfunction


task ahb_driver::run_phase(uvm_phase phase);
	@(vif.ahb_drv_cb);
		vif.ahb_drv_cb.HRESETn <= 1'b0;
	@(vif.ahb_drv_cb);
		vif.ahb_drv_cb.HRESETn <= 1'b1;
	forever 
	begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
endtask

task ahb_driver::send_to_dut(ahb_xtn xtn);
     begin
		`uvm_info("AHB DRIVER",$sformatf("Printing from driver \n %s",xtn.sprint()),UVM_LOW)
		
		vif.ahb_drv_cb.HWRITE<=xtn.HWRITE;
		vif.ahb_drv_cb.HTRANS<=xtn.HTRANS;
		vif.ahb_drv_cb.HSIZE<=xtn.HSIZE;
		vif.ahb_drv_cb.HADDR<=xtn.HADDR;
		vif.ahb_drv_cb.HREADYin<=1'b1;
		vif.ahb_drv_cb.HBURST<=xtn.HBURST;
			

		@(vif.ahb_drv_cb);
			wait(vif.ahb_drv_cb.HREADYout)
			 if(xtn.HWRITE)
                begin
				    vif.ahb_drv_cb.HWDATA <= xtn.HWDATA;
					`uvm_info("DRIVER",$sformatf("Writing to address=%0d, Written data=%0d",xtn.HADDR,xtn.HWDATA),UVM_LOW)
				end
			else
				begin	
					vif.ahb_drv_cb.HWDATA <= 32'hz;
			    	`uvm_info("DRIVER",$sformatf("Reading from address=%0d",xtn.HADDR),UVM_LOW)
			end 
       end
endtask



function void ahb_driver::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology;
endfunction
