use 5.042;

# day 11 https://adventofcode.com/2025/day/11

use ARGV::OrDATA;

my %attached;
while (my $device = <>) {
    my ($name, @attached) = $device =~ /(?|^(\S+?):(?!$)|\G (\S++))/g
        or die "bad: $device";

    push $attached{$name}->@*, @attached;
}

my $paths = path_count('you', 'out');
say $paths;

sub path_count($next, $out) {
    my $paths = 0;
    for my $attached ($attached{$next}->@*) {
        if ($attached eq $out) {
            ++$paths;
        }
        else {
            $paths += path_count($attached, $out);
        }
    }
    return $paths;
}

__DATA__
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
