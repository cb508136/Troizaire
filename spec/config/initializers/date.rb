class Date
	class << self
		def _parse_with_i18n(str, format = :default)
			format ||= :default
			date = Date._strptime(str, I18n.translate("date.formats.#{format}")) || _parse_without_i18n(str)
			date[:year] += increment_year(date[:year].to_i) if date[:year]
			date
		end

		#alias_method_chain :_parse, :i18n
                alias_method :_parse_without_i18n, :_parse
                alias_method :_parse, :_parse_with_i18n

		def parse_with_i18n(str, format = :default)
			format ||= :default
			date = Date.strptime(str, I18n.translate("date.formats.#{format}"))
			Date.new(date.year + increment_year(date.year), date.month, date.day)
			rescue ArgumentError
			parse_without_i18n(str)
		end

		#alias_method_chain :parse, :i18n
                alias_method :parse_without_i18n, :parse
                alias_method :parse, :parse_with_i18n

		def increment_year(year)
			if year < 100
				year < 30 ? 2000 : 1900
			else
				0
			end
		end

                def diff_ymd(date1,date2)

                  # Initialiser trois integer en 0
                  nb_year,nb_month,nb_day = 0,0,0

                  # convertir les deux paramètres en format Date
                  d1 = date1.to_date
                  d2 = date2.to_date
                  if d1 < d2

                          while(d1 < d2)
                            nb_year += 1
                            d1 = d1 >> 12
                          end

			  if d1 != d2
                            # Recule Un an
                            d1 = d1 << 12
                            nb_year = nb_year - 1
			  end
                          while(d1 < d2)
                            nb_month += 1
                            d1 = d1 >> 1
                          end

			  if d1 != d2
                            # Recule Un mois
                            d1 = d1 << 1
                            nb_month = nb_month - 1

                            nb_day = d2-d1
                          end

                          [nb_year,nb_month,nb_day.to_i]
                  else
                        diff_ymd(date2,date1)
                  end
                end

	end

	def l(*args)
		I18n.l(self, *args)
	end
end

class Time
	def l(*args)
		I18n.l(self, *args)
	end
end
