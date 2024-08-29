#!/usr/bin/perl

$titlelengthcutoff = 40;

sub cmus_info {
    $outstring = "♫  ";
    if ($cmusout =~ /tag title (.+?)\t/){
        $outstring .= $1;
    }
    $outstring .= " #[nobold]-#[bold] ";
    if ($cmusout =~ /tag artist (.+?)\t/){
        $outstring .= $1;
    }
    print $outstring;
} 

sub spotify_info {
    $outstring = "♫  ";
    $thetitle .= `timeout 1 playerctl metadata title`;
    if ($thetitle eq ""){
        print "";
        return;
    }
    $tmp = `timeout 1 playerctl metadata title`;
    #  TODO: untested on gnu/linux
    $outstring .= ( length($tmp) > $titlelengthcutoff : substr($tmp, 0, $titlelengthcutoff-3) . "..." : $tmp )
    $outstring .= " #[nobold]-#[bold] ";
    $outstring .= `timeout 1 playerctl metadata artist`;
    print $outstring;
}


# - - - - - - - - - - - - - #


$cmusout = `cmus-remote -Q 2>&1 | paste -s`;


if ($cmusout =~ m/status playing/){
    cmus_info();
    exit 0;
}

$spotifyout = `timeout 1 playerctl status 2>&1`;

if ($cmusout =~ m/status (stopped|paused)/ && $spotifyout =~ m/Playing/){
    spotify_info();
    exit 0;
}

if ($cmusout !~ m/not running/) {
    cmus_info();
    exit 0;
}

if ($spotifyout !~ m/No players found/){
    spotify_info();
    exit 0;
}

