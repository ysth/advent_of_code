use 5.036;
# day 6 https://adventofcode.com/2025/day/6
@ARGV = 'day6.txt' unless @ARGV;

my @data = map [split], <>;
my $sum = 0;
my $ops = pop @data;
while (my $op = shift @$ops) {
    $sum += eval join $op, map shift @$_, @data;
}
say $sum;
