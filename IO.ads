with pump;
package IO is

   --pass in a String to print a string.
   procedure print(s:in String);

   --pass in a String and a float to print a string and a number
   procedure print_float(s1:in String; s2:pump.float_number);

   --pass in a String and a pump state to print a string and a pump state.
   procedure print_state(s1:in String; s2:pump.state);

   --pass in a String and a nozzle state to print a string and a nozzle state.
   procedure print_nozzle(s1:in String; s2:pump.nozzle);

   --pass in a String and a fuel type to print a string and a fuel type.
   procedure print_fuel_types(s1:in String; s2:pump.fuel_types);

   --pass in a String to print a Boolean value.
   procedure print_boolean(s1:in String; s2:Boolean);

end IO;
