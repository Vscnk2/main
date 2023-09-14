class ahb_monitor extends uvm_monitor;

        `uvm_component_utils(ahb_monitor)

		virtual ahb_if.MON_MP vif;
      
		uvm_analysis_port #(ahb_xtn) monitor_port; 
        ahb_agt_config ahb_cfg;


        
        extern function new(string name="ahb_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
	    extern function void connect_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);
        extern task collect_data();
endclass


function ahb_monitor::new(string name="ahb_monitor",uvm_component parent);
        super.new(name,parent);
		monitor_port=new("monitor_port",this);
endfunction


function void ahb_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);

                if(!uvm_config_db #(ahb_agt_config)::get(this,"","ahb_agt_config",ahb_cfg))
                        `uvm_fatal("CONFIG","Cannot get() ahb_agent_config from uvm_config_db.Is it set()?")
endfunction


function void ahb_monitor::connect_phase(uvm_phase phase);
        vif=ahb_cfg.vif;
endfunction

task ahb_monitor::run_phase(uvm_phase phase);
        forever
                collect_data();
endtask

task ahb_monitor::collect_data();
	ahb_xtn data_sent;
	
	data_sent=ahb_xtn::type_id::create("ahb_xtn");
	
	wait((vif.ahb_mon_cb.HTRANS==2'b10)||(vif.ahb_mon_cb.HTRANS==2'b11)&& (vif.ahb_mon_cb.HREADYout))
	
	data_sent.HTRANS = vif.ahb_mon_cb.HTRANS;
	data_sent.HSIZE = vif.ahb_mon_cb.HSIZE;
	data_sent.HBURST = vif.ahb_mon_cb.HBURST;
	data_sent.HADDR = vif.ahb_mon_cb.HADDR;
	data_sent.HWRITE = vif.ahb_mon_cb.HWRITE;
	@(vif.ahb_mon_cb);
	if(vif.ahb_mon_cb.HWRITE)
	begin
		data_sent.HWDATA = vif.ahb_mon_cb.HWDATA;
	end
	else
	begin	
		data_sent.HRDATA = vif.ahb_mon_cb.HRDATA;
	end
	`uvm_info("AHB MONITOR",$sformatf("Printing from monitor \n %s",data_sent.sprint()),UVM_LOW)
	monitor_port.write(data_sent);
endtask