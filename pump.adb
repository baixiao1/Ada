with pump;
with IO; use IO;
package body pump
with SPARK_Mode is

   procedure set_state(pump_num : in out pump; pumpstate: in state) is
   begin
      pump_num.pump_state:= pumpstate;
      print_state("The pump state is changed to: ", pumpstate);
   end set_state;

   procedure set_nozzle_state(pump_num: in out pump; nozzlestate:in nozzle) is
   begin
      pump_num.pump_nozzle_state:=nozzlestate;
      print_nozzle("The nozzle state is changed to: ", nozzlestate);
   end set_nozzle_state;

   procedure set_reservoir_size(pump_num: in out pump; size: in float_number) is
   begin
      pump_num.reservoir_info.total:= size;
      print_float("Size of the reservoir is: ", size);
   end set_reservoir_size;

   procedure remove_reservoir(pump_num: in out pump) is
   begin
      if pump_num.reservoir_info.total > 1.00 then
         pump_num.reservoir_info.total := pump_num.reservoir_info.total-1.00;
      end if;
   end remove_reservoir;

   procedure set_fuel_amount(pump_num: in out pump; amount: in float_number) is
   begin
      pump_num.fuel_amount := amount;
   end set_fuel_amount;

   procedure set_reservoir(pump_num: in out pump; fueltype:in fuel_types) is
      r : reservoir;
   begin
      r.reservoir_type:=fueltype;
      r.total:=1000.00;
      pump_num.reservoir_info:=r;
      print_fuel_types("Add Reservoir: ", fuelType);
   end set_reservoir;

   procedure set_price(pump_num: in out pump; price: in float_number) is
   begin
      pump_num.unit_price:=price;
      print_float("The unit price is: ", price);
   end set_price;


   function get_price(pump_num: in pump) return float_number is
   begin
      return pump_num.unit_price;
   end get_price;

   function get_total(pump_num: in pump) return float_number is
   begin
      return pump_num.reservoir_info.total;
   end get_total;

   function get_reservoir(pump_num: in pump) return fuel_types is
   begin
      return pump_num.reservoir_info.reservoir_type;
   end get_reservoir;

   function get_nozzle_state(pump_num: in pump) return nozzle is
   begin
      return pump_num.pump_nozzle_state;
   end get_nozzle_state;

   function get_state(pump_num: in pump) return state is
   begin
      return pump_num.pump_state;
   end get_state;

end pump;
