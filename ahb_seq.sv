class ahb_base_seq extends uvm_sequence #(ahb_xtn);
       
    `uvm_object_utils(ahb_base_seq)
        
	bit [31:0]haddr;
	bit [2:0] hsize;
	bit hwrite;
	bit [2:0]hburst;
	
extern function new(string name = "ahb_base_seq");

endclass

//-------------------------------------------------- constructor new method--------------------------------
function ahb_base_seq ::new(string name = "ahb_base_seq");
        super.new(name);
endfunction

class single_xtn extends ahb_base_seq;
	`uvm_object_utils(single_xtn)

	extern function new(string name = "single_xtn");
	extern task body();

endclass
//------------------------------------------------SINGLE-TRANSFER-----------------------------------------------
function single_xtn::new(string name = "single_xtn");
	super.new(name);
endfunction

task single_xtn::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	   assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b000;});
	finish_item(req);
	
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;
	
	start_item(req);
	assert(req.randomize()with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
	
	
end
endtask
//-------------------------------------------------WRAP4------------------------------------------------

class ahb_wrap4_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap4_seq)
	
	extern function new(string name="ahb_wrap4_seq");
	extern task body();
endclass

function ahb_wrap4_seq::new(string name="ahb_wrap4_seq");
	super.new(name);
endfunction

task ahb_wrap4_seq::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b010;});
	finish_item(req);
    
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;
	
	repeat(3)	
	begin	
		start_item(req);
		
		if(hsize == 20)
               assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+1'b1);});

         if(hsize == 1)
               assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+2'b10);});

         if(hsize == 2)
               assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+3'b100);});
                   
		finish_item(req);

	haddr=req.HADDR;
	end

	start_item(req);
		assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
	
end
endtask

//-------------------------------------------------------------------INCR4---------------------------------------------------------------	
class ahb_incr4_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_incr4_seq)
	
	extern function new(string name="ahb_incr4_seq");
	extern task body();
endclass

function ahb_incr4_seq::new(string name="ahb_incr4_seq");
	super.new(name);
endfunction

task ahb_incr4_seq::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b011;});
	finish_item(req);
	
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;
	
	repeat(3)
	begin	
		start_item(req);
		 if(hsize == 0)
            assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+1'b1);});
                       
         if(hsize == 1)
            assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+2'b10);});
                        
         if(hsize == 2)
            assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+3'b100);});

        finish_item(req);

      haddr = req.HADDR;
	end
	
	start_item(req);
	    assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
end
endtask
//---------------------------------------------------------------------------------------------------------------------	

class unspecified_seq extends ahb_base_seq;

	`uvm_object_utils(unspecified_seq)
	
	extern function new(string name="unspecified_seq");
	extern task body();
endclass

function unspecified_seq::new(string name="unspecified_seq");
	super.new(name);
endfunction

task unspecified_seq::body();
int i;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b001;});
	finish_item(req);
	
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;	 
	
	for(i=0;i<req.length;i=i+1)
	begin	
		start_item(req);

            if(hsize == 0)
                assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+1'b1);});

            if(hsize == 1)
                assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+2'b10);});

            if(hsize == 2)
                assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+3'b100);});

        finish_item(req);

     haddr = req.HADDR;
	end
	
	start_item(req);
	    assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
end
endtask

//--------------------------------------------------------------------------------------------------------------------------------------	
	
class ahb_wrap8_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap8_seq)
	
	extern function new(string name="ahb_wrap8_seq");
	extern task body();
endclass

function ahb_wrap8_seq::new(string name="ahb_wrap8_seq");
	super.new(name);
endfunction

task ahb_wrap8_seq::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b100;});
	finish_item(req);
	
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;	
	
	repeat(7)
	begin	
	 start_item(req);
						
		if(hsize == 0)
            assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == {haddr[31:3], haddr[2:0] + 1'b1};});

        if(hsize == 1)
           assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == {haddr[31:4], haddr[3:1] + 1'b1, haddr[0]};});

        if(hsize == 2)
           assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == {haddr[31:5], haddr[4:2] + 1'b1, haddr[1:0]};});

    finish_item(req);
	end

	start_item(req);
	 assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
end
endtask
//-------------------------------------------------------------------------------------------------------------------------------------

class ahb_incr8_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_incr8_seq)
	
	extern function new(string name="ahb_incr8_seq");
	extern task body();
endclass

function ahb_incr8_seq::new(string name="ahb_incr8_seq");
	super.new(name);
endfunction

task ahb_incr8_seq::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b101;});
	finish_item(req);

	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;		

	repeat(7)
	  begin
         start_item(req);

             if(hsize == 0)
               assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+1'b1);});
                       
             if(hsize == 1)
               assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+2'b10);});
                        
             if(hsize == 2)
               assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+3'b100);});

         finish_item(req);

        haddr = req.HADDR;
       end
      

	start_item(req);
	 assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
end
endtask	
//------------------------------------------------------------------------------------------------------------------
class ahb_wrap16_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap16_seq)
	
	extern function new(string name="ahb_wrap16_seq");
	extern task body();
endclass

function ahb_wrap16_seq::new(string name="ahb_wrap16_seq");
	super.new(name);
endfunction

task ahb_wrap16_seq::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b110;});
	finish_item(req);
	
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;
	
	repeat(15)
	begin	
	
		start_item(req);
						
			if(hsize == 0)
              assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == {haddr[31:4], haddr[3:0] + 1'b1};});

            if(hsize == 1)
              assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == {haddr[31:5], haddr[4:1] + 1'b1, haddr[0]};});

            if(hsize == 2)
              assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == {haddr[31:6], haddr[5:2] + 1'b1, haddr[1:0]};});

        finish_item(req);

        haddr = req.HADDR;
	end
	
	start_item(req);
	 assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
 end
endtask

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
class ahb_incr16_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_incr16_seq)
	
	extern function new(string name="ahb_incr16_seq");
	extern task body();
endclass

function ahb_incr16_seq::new(string name="ahb_incr16_seq");
	super.new(name);
endfunction

task ahb_incr16_seq::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b111;});
	finish_item(req);
	
	haddr=req.HADDR;
	hsize=req.HSIZE;
	hburst=req.HBURST;
	hwrite=req.HWRITE;
	
	repeat(15)
	begin	
	   start_item(req);

        if(hsize == 0)
          assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+1'b1);});
                      
        if(hsize == 1)
          assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+2'b10);});
                        
        if(hsize == 2)
          assert(req.randomize() with {HSIZE == hsize; HBURST == hburst; HWRITE == hwrite; HTRANS == 2'b11; HADDR == (haddr+3'b100);});

       finish_item(req);

      haddr = req.HADDR;
	end
	
	start_item(req);
	 assert(req.randomize() with {HWRITE==hwrite;HTRANS==2'b00;HSIZE==hsize;HBURST==hburst;});
	finish_item(req);
end
endtask
