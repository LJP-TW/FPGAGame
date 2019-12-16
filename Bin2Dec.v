module Bin2Dec(Bin, Seg7);
  input [12:0] Bin;
  output [31:0] Seg7;
  wire [3:0] n0, n1, n2, n3;
  wire [7:0] tmp;
  
  assign n3 = Bin/1000;
  assign n2 = (Bin % 1000)/100;
  assign n1 = (Bin % 100)/10;
  assign n0 = (Bin % 10);
  assign Seg7[23:16] = {1'b0, tmp[6:0]};
  
  Seg7Decode s0(n0, Seg7[7:0]);
  Seg7Decode s1(n1, Seg7[15:8]);
  Seg7Decode s2(n2, tmp[7:0]);
  Seg7Decode s3(n3, Seg7[31:24]);
endmodule