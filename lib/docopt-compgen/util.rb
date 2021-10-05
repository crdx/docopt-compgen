module DocoptCompgen
    class Util
        def self.slugify(str)
            str.gsub(' ', '_')
               .gsub(/[^\w_]/, '_')
               .gsub(/_+/, '_')
               .gsub(/_$/, '')
               .gsub(/^_/, '')
        end
    end
end
