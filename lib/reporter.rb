class Reporter
  COLUMN_SIZE = 10
  COLUMN_GAP_SIZE = 2

  attr_reader :report
  attr_reader :iterations

  def initialize(report, iterations)
    @report = report
    @iterations = iterations
  end

  def print
    print_header
    print_results
    print_summary
  end

  private

  def print_header
    print_row(%w(gem user system total real))
    print_separator
  end

  def print_results
    report.to_a.sort { |a, b| b.last[:real] <=> a.last[:real] }.each do |name, info|
      user = info[:user] / iterations
      system = info[:system] / iterations
      total = info[:total] / iterations
      real = info[:real] / iterations

      print_row([name, user, system, total, real])
    end

    print_separator
  end

  def print_summary
    sum_user = 0.0
    sum_system = 0.0
    sum_total = 0.0
    sum_real = 0.0

    report.values.each do |info|
      sum_user += info[:user] / iterations
      sum_system += info[:system] / iterations
      sum_total += info[:total] / iterations
      sum_real += info[:real] / iterations
    end

    print_row(['TOTAL', sum_total, sum_system, sum_total, sum_real])
  end

  def print_row(items)
    row = ""
    items.each_with_index do |value, index|
      first_column = index == 0

      if first_column
        row << value.to_s.ljust(first_column_padding)
      else
        if value.is_a?(Float)
          row << sprintf("%0.#{COLUMN_SIZE - 2}f", value)
        else
          row << value.to_s.ljust(COLUMN_SIZE)
        end
      end

      row << " " * COLUMN_GAP_SIZE
    end

    puts row
  end

  def print_separator
    total_length = (first_column_padding + (COLUMN_SIZE + COLUMN_GAP_SIZE) * 4)
    puts('-' * total_length)
  end

  def first_column_padding
    report.keys.collect(&:size).max
  end
end
