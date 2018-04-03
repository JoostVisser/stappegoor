class Constants < ActiveRecord::Base
    def self.prices
        {
            standard: 10.75,
            luxe: 13.75,
            film: 17.45,
            special_discount: 4.50,
            camera: 9.95,
            glasses: 1.00
        }
    end
end
