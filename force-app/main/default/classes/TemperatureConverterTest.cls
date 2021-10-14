@isTest
public class TemperatureConverterTest {
    @isTest static void testWarmTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    
    @isTest static void testFreezingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0,celsius);
    }
    
    @isTest static void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);        
        System.assertEquals(100,celsius,'Boiling point temperature is not expected.');
    } 
    
    @isTest static void testNegativeTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius);
    }

    @isTest static void testCsToFhFreezingPoint() {
        Decimal fahr = TemperatureConverter.CelsiusToFahrenheit(0);
        System.assertEquals(32,fahr);
    }
    
    @isTest static void testCsToFhAboveZero() {
        Decimal fahr = TemperatureConverter.CelsiusToFahrenheit(5);
        System.assertEquals(41,fahr);
    }

}