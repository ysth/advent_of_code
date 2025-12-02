use 5.036;
# day 2 https://adventofcode.com/2025/day/2
# input is a comma separated list of low-high numeric ranges
# sum the numbers in the ranges are of once repeated digits (99, 1010, etc.)
@ARGV = 'day2.txt' unless @ARGV;
chomp(my $ranges = <>);
my $sum = 0;
for my $range (split /,/, $ranges) {
    my ($from, $to) = split /-/, $range;
    for my $n ($from..$to) {
        $sum += $n if $n =~ /^(.*)\1\z/;
    }
}
say $sum;
