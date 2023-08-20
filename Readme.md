# Verilog 

- Set of projects I completed in Verilog to better learn Computer Engineering/Science from first principles.
- Most interesting project here is the UART transmitter that I wrote, whose waveform is viewable using software like gtkwave 
    - Receives parallel inputs from pins, which is then sent via output pin in serial format.
        - Transmitted as a 6 bit data frame with 1 start and 1 stop bit.
        - Also includes a Baud Rate Generator with a 10MHz MCU clock configured to a Baud Rate of 9600. 
        - I did not write a receiver, as that is too much effort. 
