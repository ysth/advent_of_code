use 5.040;
# day 10 https://adventofcode.com/2025/day/10
use ARGV::OrDATA;

my $total_presses = 0;
MACHINE:
while (my $machine = <>) {
    my ($lights, @buttons) = $machine =~ /(?|^\[([.#]+)\] |\G\((\d+(?:[,0-9]+\d)?)\) )/ag
        or die "bad: $machine";
    for my $button (@buttons) {
        my $button_mask = "";
        $button_mask |.= ("\0" x $_) . "\r" for split /,/, $button;
        $button = $button_mask;
    }
    my $statuses = {"." x length($lights) => undef};
    my $presses = 0;
    PRESSES:
    while (true) {
        ++$presses;
        my $new_statuses = {};
        for my $before (keys %$statuses) {
            for my $button (@buttons) {
                last PRESSES if $lights eq (my $after = $before ^. $button);
                $new_statuses->{$after} = ();
            }
        }
        $statuses = $new_statuses;
        if ($presses > 100) {
            print "no luck with machine:\n$machine";
            next MACHINE;
        }
    }
    $total_presses += $presses;
}
say $total_presses;
__DATA__
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
