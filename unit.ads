with pump;
--Defines the three pumps and related pumping actions.
package unit
with SPARK_Mode is
   use all type pump.nozzle;
   use all type pump.float_number;
   use all type pump.state;


   subtype unit_id is String(1..5);
   --Describes the id of a pump unit, in this case, the length of unit_id is defined as 5.
   success: Boolean:=False;
   --Judge whether a procedure was successfully executed

   type pump_unit is record
      id: unit_id:="     ";
      is_occupied: Boolean:=False;
      is_paid:Boolean:=True;
      pay:pump.float_number:=0.00;
      fuel_amount: pump.float_number:=0.00;
      avaliable_fuel: pump.fuel_types:= pump.F91;
      current_state: pump.state:= pump.Base;
      nozzle_state: pump.nozzle:=pump.Initial;
      pump_91: pump.pump;
      pump_95: pump.pump;
      pump_Diesel: pump.pump;
   end record;
   --Describes the information of a pump unit, contains unit id (unit_id),
   --whether it is being used (is_occupied), whether the payment of the unit
   --has been paid (is_paid), the needed amount of payment (pay),
   --the amount of pumped fuel (fuel_amount), the current available fuel type
   --a unit can offer (available_fuel), the current pump state of a unit (current_state),
   --the nozzle state of a unit (nozzle_state), and three pumps a unit has (pump_91, pump_95, pump_Diesel).


   --Pass in a unit and any fuel type, return the pump of the unit offers the required fuel type.
   function get_pump(unit: in pump_unit; fueltype: in pump.fuel_types) return pump.pump;

   --Pass in a unit and any fuel type, return the currently total fuel amount of the pump of the unit offers the required fuel type.
   function get_total(unit: in pump_unit; fueltype: in pump.fuel_types) return pump.float_number;

   --Pass in a unit, return its id.
   function get_id(unit: in pump_unit) return unit_id;

   --Pass in a unit, return the needed amount of payment.
   function get_pay(unit:in pump_unit) return pump.float_number;

   --Pass in a unit, return the amount of pumped fuel.
   function get_fuel_amount(unit:in pump_unit) return pump.float_number;

   --Pass in a unit, return the fuel types the unit can offer.
   function get_fuel(unit:in pump_unit) return pump.fuel_types;

   --Pass in a unit, return whether this unit is being used.
   function is_occupied(unit: in pump_unit) return Boolean;

   --Pass in a unit, return whether the payment state of this unit.
   function is_paid(unit: in pump_unit) return Boolean;

   --Pass in a unit, return the pump state of the unit.
   function get_unit_state(unit: in pump_unit)return pump.state;

   --Pass in a unit, return the nozzle state of the unit.
   function get_nozzle_state(unit: in pump_unit) return pump.nozzle;

   --pass in a unit, set the unit to be used or not.
   procedure set_is_occupied(unit: in out pump_unit)
     with
       pre=>(unit.is_occupied = True or unit.is_occupied = False),
     post=>(unit.is_occupied = False or unit.is_occupied = True);

   --pass in a unit, initially set the unit to be not paid.
   procedure set_is_paid(unit: in out pump_unit);

   --pass in a unit and the required amount of payment, transfer the payment amount to the unit.
   procedure set_pay(unit: in out pump_unit; amount: in pump.float_number);

   --pass in a unit and the wanted id for this unit, set id for it.
   procedure set_id(unit: in out pump_unit; id: in unit_id);

   --pass in a unit and a float number for fuel amount, set the amount of pumped fuel.
   procedure set_fuel_amount(unit: in out pump_unit; amount: in pump.float_number);

   --pass in a unit, a fuel type for indicating a pump, and a pump state, set the current pump state of a pump of a unit as required.
   procedure set_current_state(unit: in out pump_unit; fueltype: in pump.fuel_types; state: in  pump.state);

   --pass in a unit, a fuel type for indicating a pump, and a nozzle state, set the current nozzle state of a pump of a unit as required
   procedure set_nozzle_state(unit: in out pump_unit; fueltype: in pump.fuel_types; nozzletype: in pump.nozzle);

   --pass in a unit, a pump and any fuel type, add a pump to a unit.
   procedure add_pump(unit: in out pump_unit;pump_num : in out pump.pump; fueltype: in pump.fuel_types)
     with Depends => (unit => +(pump_num,fueltype),
                      pump_num => +(fueltype));

   --Pass in a unit, a pump, and any fuel type, a customer can lift the nozzle to enter the Ready state.
   procedure lift_nozzle(unit: in out pump_unit; pump_num : in out pump.pump; fueltype: in pump.fuel_types)
     with Depends => (unit => +(pump_num,fueltype),
                      pump_num => +(unit),
                      success => +(unit, pump_num)),
          Pre => (pump.state'Pos(pump.get_state(pump_num))=0 or pump.state'Pos(pump.get_state(pump_num))=3),
          Post => (unit.current_state=pump.Ready or success =False);

   --Pass in a unit, a pump, to return the nozzle to enter the Waiting state.
   procedure replace_nozzle (unit: in out pump_unit; pump_num : in out pump.pump)
     with Depends => (unit => +(pump_num),
                      pump_num => +(unit),
                      success => +(unit, pump_num)),
          Pre => ((pump.state'Pos(pump.get_state(pump_num))=1
               or pump.state'Pos(pump.get_state(pump_num))=3)
               and pump.nozzle'Pos(pump.get_nozzle_state(pump_num))=5),
          Post => (unit.current_state=pump.Waiting or unit.current_state=pump.Base or success =False);

   --Pass in a unit, a pump, a float number for the fuel amount that needs to be pumped, and the currently available space for fuel of a car.
   procedure start_pumping (unit: in out pump_unit; pump_num : in out pump.pump; amount: in pump.float_number; car_space: in out pump.float_number)
     with Depends => (unit => +(pump_num,amount, car_space),
                      pump_num => +(unit, amount, car_space),
                      car_space =>+(unit, pump_num,amount),
                      success => +(unit, pump_num,amount, car_space)),
          Pre => (pump.state'Pos(pump.get_state(pump_num))= 1 and pump.nozzle'Pos(pump.get_nozzle_state(pump_num))=1),
          Post => (unit.current_state = pump.Ready or success =False);

   --Pass in a unit and a pump to stop pumping.
   procedure stop_pumping (unit: in out pump_unit; pump_num : in out pump.pump)
     with Depends => (unit => +(pump_num),
                      pump_num => +(unit),
                      success => +(unit, pump_num)),
          Pre => ((pump.state'Pos(pump.get_state(pump_num))= 2 and pump.nozzle'Pos(pump.get_nozzle_state(pump_num))=3) or success=True),
          Post => ((unit.nozzle_state=pump.Stop and unit.current_state = pump.Ready) or success =False);

private

end unit;
