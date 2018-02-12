module l6q2(output reg [7:0] op, input clk,oe,input [4:0] add);
reg [5:0] i;
integer id;
reg [7:0] memrom [31:0];

initial
begin
id=$fopen("memory.txt");
for(i=0;i<32;i=i+1)
begin
$fdisplay(id,"@%h %h",i,i);
end
$fclose(2);
$readmemh("memory.txt",memrom);
end

always @ (posedge clk)
begin
if(oe)
op <= memrom[add];
end
endmodule 

//========= Read 15 to 28=========//

module l6q2a (output reg [7:0] op, input clk,oe,input [4:0] add);
reg [5:0] i;
integer id;
reg [7:0] val;
reg [7:0] memrom [31:0];

always @ (posedge clk,posedge oe)
begin
if(oe)
op <= memrom[add];
else
op<=0;
end

initial
begin
id=$fopen("memory1.txt");
for(i=0;i<32;i=i+1)
begin
$fdisplay(id,"%h",i);
end
$fclose(2);
$readmemh("memory1.txt",memrom,15,28);
end
endmodule

//===============TB==============//
module tb();

wire [7:0] top,top1;
reg tclk,toe;
reg [4:0] tadd;
integer tid,tid1;
integer i;
l6q2 t1 (top,tclk,toe,tadd);
l6q2a t2 (top1,tclk,toe,tadd);
always
begin
#5 tclk=1;
#5 tclk=0;
end

initial
begin
tid=$fopen("memory_out.txt");
tid1=$fopen("memory_out1.txt");
end

initial
begin
  $fmonitor(tid|1,"@%h %h", tadd,top);
  $fmonitor(tid1,"@%h %h",tadd,top1);
  for(i=0;i<32;i=i+1)
  begin
   tadd=i; toe=1;#10;
   end
$fclose(6);
end
endmodule