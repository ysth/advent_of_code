use 5.036;
# day 6 https://adventofcode.com/2025/day/6
@ARGV = 'day6.txt' unless @ARGV;

chomp(my @data = <>);
my @ops = split ' ', pop @data;

my $sum = 0;
while (my $op = shift @ops) {
    my @operands;
    {
        my $operand = join '', map substr($_, 0, 1, ''), @data;
        if ($operand =~ /\d/a) {
            push @operands, $operand;
            redo;
        }
    }
    $sum += eval join $op, @operands;
}
say $sum;
