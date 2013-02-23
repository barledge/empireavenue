module EmpireAvenue
  class Version
    MAJOR = 0 unless defined? EmpireAvenue::Version::MAJOR
    MINOR = 0 unless defined? EmpireAvenue::Version::MINOR
    PATCH = 3 unless defined? EmpireAvenue::Version::PATCH
    PRE = nil unless defined? EmpireAvenue::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
