package Dist::Zilla::Plugin::Web::FileHeader;
{
  $Dist::Zilla::Plugin::Web::FileHeader::VERSION = '0.0.4';
}

# ABSTRACT: Prepend header to files

use Moose;
use Path::Class;

with 'Dist::Zilla::Role::FileMunger';


has 'header_filename' => (
    isa     => 'Str',
    is      => 'rw'
);


has 'file_match' => (
    is      => 'rw',

    default => sub { [ '^lib/.*\\.js$' ] }
);


has 'exculde_match' => (
    is      => 'rw',

    default => sub { [] }
);


sub mvp_multivalue_args { qw( file_match exculde_match ) }


#================================================================================================================================================================================================================================================
sub munge_files {
    my $self = shift;
    
    return unless -e $self->header_filename;
    
    my $header_content  = file($self->header_filename)->slurp();
    
    my $version         = $self->zilla->version;
    
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
    
    # perl is such an oldboy :)
    $year += 1900;
    
    $header_content     =~ s/%v/$version/;  
    $header_content     =~ s/%y/$year/;

    # never match (at least the filename characters)
    my $matches_regex = qr/\000/;
    my $exclude_regex = qr/\000/;

    $matches_regex = qr/$_|$matches_regex/ for (@{$self->file_match});
    $exclude_regex = qr/$_|$exclude_regex/ for (@{$self->exculde_match});

    for my $file (@{$self->zilla->files}) {
        next unless $file->name =~ $matches_regex;
        next if     $file->name =~ $exclude_regex;

        $file->content($header_content . $file->content);
    }
}


#================================================================================================================================================================================================================================================
sub prepend_header_to_file {
    my ($self, $file) = @_;
    
    return unless -e $self->header_filename;
    
    my $header_content  = file($self->header_filename)->slurp();
    
    my $version         = $self->zilla->version;
    
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
    
    # perl is such an oldboy :)
    $year += 1900;
    
    $header_content     =~ s/%v/$version/;  
    $header_content     =~ s/%y/$year/;

    my $file_content    = file($file)->slurp;
    
    my $fh              = file($file)->openw;
    
    print $fh $header_content . $file_content;
    
    $fh->close();
}




no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;



__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::Web::FileHeader - Prepend header to files

=head1 VERSION

version 0.0.4

=head1 SYNOPSIS

In your F<dist.ini>:

    [Web::FileHeader]
    header_filename = build/header.txt
    
    file_match = ^lib/.*\.js$           ; default, regex for file names to process 
    file_match = ^lib/.*\.css$          ; allow several values
    excelude_match = ^lib/special.css$  ; default, regex for file names to exclude 
                                        ; from processing
    excelude_match = ^lib/donotinclude.css$  ; allow several values

In your "build/header.txt":

    /*
    
    My Project %v
    Copyright(c) 2009-%y My Company
    
    */

=head1 DESCRIPTION

This plugin will prepend the content of the file specified with the "header_filename" option to all files in your
distribution, matching any of the "file_match" regular expressions. Files matching any of the "excelude_match"
regular expression will not be processed.

When prepending the header, the "%v" placeholder will be replaced with the version of distribution. The "%y" placeholder
will be replaced with the current year.

=head1 AUTHOR

Nickolay Platonov <nplatonov@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Nickolay Platonov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

