with unit;
with pump;
--Defines the cashier
package cash_register

with SPARK_Mode is

   subtype unit_id is String(1..5);
   --Describes the id of a pump unit, in this case, the length of unit_id is defined as 5.

   type pump_unit_id is record
      id: unit.unit_id;
      pay: pump.float_number;
      fuel_amount: pump.float_number;
      fuel: pump.fuel_types;
   end record;
   --Defines the id of a unit (id), its payment (pay), the pumped fuel amount (fuel_amount), its fuel type (fuel).

   type cash_register is record
         unit1: pump_unit_id;
   end record;
   --Defines the units a cash register has (unit1), in this case, we only have one pump unit.

   cashregister: cash_register;

   --pass in a unit, a pump, and a float number as the money paid by the customer to transfer the payment into the cashier.
   procedure payment(pumpunit: in out unit.pump_unit; pump_num: in out pump.pump; amount: in pump.float_number)
     with Depends => (pumpunit => +(cashregister,amount),
                      pump_num => +(pumpunit, cashregister,amount),
                      cashregister => +(pumpunit,amount));

   --pass in a unit to register a unit information to the cashier.
   procedure pump_info (pumpunit: in unit.pump_unit)
     with Depends => (--pumpunit => +null,
                      cashregister => pumpunit);
end cash_register;
