class virtual_seq extends uvm_sequence #(uvm_sequence_item);

        `uvm_object_utils(virtual_seq)
        
        ahb_sequencer ahb_seqrh;
        apb_sequencer apb_seqrh;
        virtual_sequencer vsqrh;
		env_config cfg_h;
		
		
		single_xtn single_ahb;
		ahb_wrap4_seq wrap4_ahb;
		ahb_wrap8_seq wrap8_ahb;
		ahb_wrap16_seq wrap16_ahb;
		ahb_incr4_seq incr4_ahb;
		ahb_incr8_seq incr8_ahb;
		ahb_incr16_seq incr16_ahb;
		unspecified_seq	unspec_ahb;
 extern function new(string name = "virtual_seq");
 extern task body();
endclass


function virtual_seq::new(string name="virtual_seq");
	super.new(name);
endfunction

task virtual_seq::body();
	if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",cfg_h))
		`uvm_fatal("CONFIG","Cannot get() env_config from uvm_config_db.Is it set?")
	assert($cast(vsqrh,m_sequencer))
	else
	begin
		`uvm_error("BODY","Error in $cast")
	end
	ahb_seqrh=vsqrh.ahb_seqrh;
	apb_seqrh=vsqrh.apb_seqrh;
endtask

class single_vseq extends virtual_seq;

	`uvm_object_utils(single_vseq)

	extern function new(string name="single_vseq");
	extern task body();
endclass

function single_vseq::new(string name="single_vseq");
	super.new(name);
endfunction

task single_vseq::body();
	super.body();
	single_ahb=single_xtn::type_id::create("single_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		single_ahb.start(ahb_seqrh);
	end
endtask

class ahb_incr4_vseq extends virtual_seq;

	`uvm_object_utils(ahb_incr4_vseq)

	extern function new(string name="ahb_incr4_vseq");
	extern task body();
endclass

function ahb_incr4_vseq::new(string name="ahb_incr4_vseq");
	super.new(name);
endfunction

task ahb_incr4_vseq::body();
	super.body();
	incr4_ahb=ahb_incr4_seq::type_id::create("incr4_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		incr4_ahb.start(ahb_seqrh);
	end
endtask


class unspecified_vseq extends virtual_seq;

	`uvm_object_utils(unspecified_vseq)

	extern function new(string name="unspecified_vseq");
	extern task body();
endclass

function unspecified_vseq::new(string name="unspecified_vseq");
	super.new(name);
endfunction

task unspecified_vseq::body();
	super.body();
	unspec_ahb=unspecified_seq::type_id::create("unspec_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		unspec_ahb.start(ahb_seqrh);
	end
endtask

class ahb_wrap4_vseq extends virtual_seq;

	`uvm_object_utils(ahb_wrap4_vseq)

	extern function new(string name="ahb_wrap4_vseq");
	extern task body();
endclass

function ahb_wrap4_vseq::new(string name="ahb_wrap4_vseq");
	super.new(name);
endfunction

task ahb_wrap4_vseq::body();
	super.body();
	wrap4_ahb=ahb_wrap4_seq::type_id::create("wrap4_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		wrap4_ahb.start(ahb_seqrh);
	end
endtask


class ahb_incr8_vseq extends virtual_seq;

	`uvm_object_utils(ahb_incr8_vseq)

	extern function new(string name="ahb_incr8_vseq");
	extern task body();
endclass

function ahb_incr8_vseq::new(string name="ahb_incr8_vseq");
	super.new(name);
endfunction


task ahb_incr8_vseq::body();
	super.body();
	incr8_ahb=ahb_incr8_seq::type_id::create("incr8_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		incr8_ahb.start(ahb_seqrh);
	end
endtask


class ahb_wrap8_vseq extends virtual_seq;

	`uvm_object_utils(ahb_wrap8_vseq)

	extern function new(string name="ahb_wrap8_vseq");
	extern task body();
endclass

function ahb_wrap8_vseq::new(string name="ahb_wrap8_vseq");
	super.new(name);
endfunction


task ahb_wrap8_vseq::body();
	super.body();
	wrap8_ahb=ahb_wrap8_seq::type_id::create("wrap8_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		wrap8_ahb.start(ahb_seqrh);
	end
endtask

class ahb_incr16_vseq extends virtual_seq;
	`uvm_object_utils(ahb_incr16_vseq)

	extern function new(string name="ahb_incr16_vseq");
	extern task body();
endclass

function ahb_incr16_vseq::new(string name="ahb_incr16_vseq");
	super.new(name);
endfunction

task ahb_incr16_vseq::body();
	super.body();
	incr16_ahb=ahb_incr16_seq::type_id::create("incr16_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		incr16_ahb.start(ahb_seqrh);
	end
endtask

class ahb_wrap16_vseq extends virtual_seq;

	`uvm_object_utils(ahb_wrap16_vseq)

	extern function new(string name="ahb_wrap16_vseq");
	extern task body();
endclass

function ahb_wrap16_vseq::new(string name="ahb_wrap16_vseq");
	super.new(name);
endfunction

task ahb_wrap16_vseq::body();
	super.body();
	wrap16_ahb=ahb_wrap16_seq::type_id::create("wrap16_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		wrap16_ahb.start(ahb_seqrh);
	end
endtask
