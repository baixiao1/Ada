with Ada.Text_IO; use Ada.Text_IO;
with pump;
package body IO is
   procedure print(s: in String) is
   begin
      if s = "" then
         New_Line;
      else
         Put_Line(s);
      end if;
   end print;

   procedure print_float(s1:in String; s2:pump.float_number) is
   begin
      Put_Line(s1 & s2'Image);
   end print_float;

   procedure print_state(s1:in String; s2:pump.state) is
   begin
      Put_Line(s1 &" "& s2'Image);
   end print_state;

   procedure print_nozzle(s1:in String; s2:pump.nozzle) is
   begin
      Put_Line(s1 &"  "& s2'Image);
   end print_nozzle;

   procedure print_fuel_types(s1:in String; s2:pump.fuel_types) is
   begin
      Put_Line(s1 & s2'Image);
   end print_fuel_types;

   procedure print_boolean(s1:in String; s2:Boolean) is
   begin
      Put_Line(s1 & s2'Image);
   end print_boolean;

end IO;
