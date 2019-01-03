class Constants < ActiveRecord::Base
    def self.prices
        {
            standard: 11.25,
            luxe: 14.40,
            film: 18.30,
            special_discount: 4.60,
            camera: 9.95,
            glasses: 1.00
        }
    end
    
    def self.names
        {
            standard: "Zwemfeestje Strandbal",
            luxe: "Zwemfeestje Surfplank",
            film: "Zwemfeestje Catamaran"
        }
    end
end
