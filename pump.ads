
--Defines the necessary sub programs for each pump.

package pump
with SPARK_Mode is
   type float_number is digits 3 range 0.00 .. 1.0E20;
   type fuel_types is (F91,F95,Diesel);  --Describes the fuel types, contains 91, 95, Diesel.
   type state is (Base, Ready, Pumping, Waiting);  --Describes the state of a pump.
   type nozzle is (Initial, Lift, Replace, Start, Stop, Pay);  --Describes the state of a nozzle.

   type reservoir is record
      total: float_number;
      reservoir_type: fuel_types;
   end record;
   --Describes a reservoir, contains its fuel amount (total) and the fuel type (reservoir_type).

   type pump is record
      reservoir_info: reservoir:=(total=>10.00,reservoir_type=>fuel_types'Val(0));
      pump_state: state:=state'Val(0);
      pump_nozzle_state: nozzle:= nozzle'Val(0);
      fuel_amount:float_number:=0.00;
      unit_price: float_number := 0.00;
      fuel_type:fuel_types:=fuel_types'Val(0);
   end record;
   --Describes a pump, contains the reservoir it connects (reservoir_info),
   --its current state (pump state), the nozzle state (pump_nozzle_state),
   --current fuel amount the pump has (fuel_amount), the unit price for
   --fuel (unit_price), and its fuel type (fuel_type).

   --pass in a pump and a pump state, change the pump state as required.
   procedure set_state(pump_num : in out pump; pumpstate: in state);

   --pass in a pump and a nozzle state, change the nozzle state as required.
   procedure set_nozzle_state(pump_num: in out pump; nozzlestate:in nozzle);

   --pass in a pump and a float number for required amount, change the fuel amount of the reservoir as required.
   procedure set_reservoir_size(pump_num: in out pump; size: in float_number);

   --pass in a pump and a float number as required amount, remove one litre of the reservoir as required.
   procedure remove_reservoir(pump_num: in out pump)
     with Post=>(get_total(pump_num)>=0.00);

   --pass in a pump and a float number as the required fuel amount, set the pumped fuel amount of the pump as required.
   procedure set_fuel_amount(pump_num: in out pump; amount: in float_number);

   --pass in a pump and any fuel type, add a reservoir for a pump, setting the fuel amount and fuel type for the reservoir.
   procedure set_reservoir(pump_num: in out pump; fueltype:in fuel_types);

   --pass in a pump and the unit price for a fuel type, setting the unit price for the fuel.
   procedure set_price(pump_num: in out pump; price: in float_number);

   --Pass in a pump, return the unit fuel price of a pump.
   function get_price(pump_num: in pump) return float_number;

   --Pass in a pump, return the current fuel amount of a pump.
   function get_total(pump_num: in pump) return float_number;

   --Pass in a pump, return the fuel type a pump offers.
   function get_reservoir(pump_num: in pump) return fuel_types;

   --Pass in a pump, return the current nozzle state of a pump.
   function get_nozzle_state(pump_num: in pump) return nozzle;

   --Pass in a pump, return the current pump state of a pump.
   function get_state(pump_num: in pump) return state;

private


end pump;

