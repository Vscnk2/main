class ahb_agt extends uvm_agent;
i am nagesh from hyd
        `uvm_component_utils(ahb_agt)

        ahb_agt_config ahb_cfg;

        ahb_monitor ahb_mon;
        ahb_driver ahb_drv;
        ahb_sequencer ahb_seqr;

      
        extern function new(string name="ahb_agt", uvm_component parent=null);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
endclass:ahb_agt

function ahb_agt::new(string name="ahb_agt", uvm_component parent=null);
        super.new(name,parent);
endfunction:new

function void ahb_agt::build_phase(uvm_phase phase);
        super.build_phase(phase);

        
        if(!uvm_config_db #(ahb_agt_config)::get(this,"","ahb_agt_config",ahb_cfg))
                `uvm_fatal("CONFIG","Cannot get() ahb_agent_config from uvm_config_db.Is it set()?")

       
        ahb_mon=ahb_monitor::type_id::create("ahb_mon",this);

        if(ahb_cfg.is_active==UVM_ACTIVE)
        begin
                ahb_drv=ahb_driver::type_id::create("ahb_drv",this);
                ahb_seqr=ahb_sequencer::type_id::create("ahb_seqr",this);
        end
endfunction:build_phase


function void ahb_agt::connect_phase(uvm_phase phase);
    
        if(ahb_cfg.is_active==UVM_ACTIVE)
                ahb_drv.seq_item_port.connect(ahb_seqr.seq_item_export);
endfunction:connect_phase
