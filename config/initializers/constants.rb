class Constants < ActiveRecord::Base
    def self.prices
        {
            standard: 10.25,
            luxe: 13.25,
            film: 16.95,
            special_discount: 4.50,
            camera: 9.95,
            glasses: 1.00
        }
    end
end