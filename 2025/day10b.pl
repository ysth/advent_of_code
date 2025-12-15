use 5.042;

# day 10 https://adventofcode.com/2025/day/10

use PDL;
use PDL::Opt::GLPK;
use ARGV::OrDATA;

my $total_presses = 0;
MACHINE:
while (my $machine = <>) {
    my ($lights, @buttons) = $machine =~ /(?|^\[([.#]+)\] |\G\((\d+(?:[,0-9]+\d)?)\) |\G\{(\d+(?:[,0-9]+\d)?)\}$)/ag
        or die "bad: $machine";

    my $target_joltages = [ split /,/, pop @buttons ];
    my $num_counters = @$target_joltages;
    my $num_buttons = @buttons;
    for my $button (@buttons) {
        my @counters = (0) x $num_counters;
        $counters[$_] = 1 for split /,/, $button;
        $button = \@counters;
    }
    glpk(
        ones($num_buttons),
        pdl(\@buttons)->transpose,
        pdl($target_joltages),
        zeroes($num_buttons),
        inf($num_buttons),
        pdl([(GLP_FX) x $num_counters]),
        pdl([(GLP_IV) x $num_buttons]),
        GLP_MIN,
        my $solution = null,
        my $presses = null,
        my $status = null,
    );
    $total_presses += $presses;
}
say $total_presses;

__DATA__
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
