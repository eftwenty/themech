module Constants
  ### REGEXPS
  ALPHA_REGEX = /\A^[A-z ]+$\z/
  PHONE_NUMBER_REGEX = /\A^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$\z/

  ### Types
  USER_STATUS = %w(Free Busy)

  ORDER_STATUS = [
      'Canceled',
      'Pending',
      'In progress',
      'Completed',
  ]

  GENDER = %w(Male Female)

  MAN_HOUR_PRICE = 10

  MAKE = [
		'ALFA ROMEO',
		'AUDI',
		'BENTLEY',
		'BMW',
		'CADILLAC',
		'CHEVROLET',
		'CHRYSLER',
		'CITROEN',
		'DODGE',
		'FERRARI',
		'FIAT',
		'FORD',
		'HONDA',
		'HYUNDAI',
		'INFINITI',
		'JAGUAR',
		'KIA',
		'LAMBORGHINI',
		'LAND ROVER',
		'LEXUS',
		'MASERATI',
		'MAZDA',
		'MERCEDES',
		'MINI',
		'MITSUBISHI',
		'NISSAN',
		'PEUGEOT',
		'PORSCHE',
		'RENAULT',
		'ROLLS-ROYCE',
		'SAAB',
		'SUBARU',
		'SUZUKI',
		'TOYOTA',
		'VOLKSWAGEN',
  ]
end