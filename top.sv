module top;

	
	import test_pkg::*;

	import uvm_pkg::*;

	bit clock;

	always
		#10 clock=~clock;

	ahb_if h_in(clock);
	apb_if p_in(clock);
	

	rtl_top DUV (.Hclk(clock),.Hresetn(h_in.HRESETn),.Htrans(h_in.HTRANS),.Hsize(h_in.HSIZE),.Hreadyin(h_in.HREADYin),.Hwdata(h_in.HWDATA),
		     .Haddr(h_in.HADDR),.Hwrite(h_in.HWRITE),.Prdata(p_in.prdata),.Hrdata(h_in.HRDATA),.Hresp(h_in.HRESP),.Hreadyout(h_in.HREADYout),
		     .Pselx(p_in.pselx),.Pwrite(p_in.pwrite),.Penable(p_in.penable),.Paddr(p_in.paddr),.Pwdata(p_in.pwdata)) ;


initial 
	begin
			uvm_config_db #(virtual ahb_if)::set(null,"*","ahb_vif",h_in);
	        uvm_config_db #(virtual apb_if)::set(null,"*","apb_vif",p_in);
			run_test();
	end

endmodule
