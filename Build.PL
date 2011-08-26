
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Collectiof of web-related plugins for DZil',
  'dist_author' => [
    'Nickolay Platonov <nplatonov@cpan.org>'
  ],
  'dist_name' => 'Dist-Zilla-Plugin-Web',
  'dist_version' => '0.0.2',
  'license' => 'perl',
  'module_name' => 'Dist::Zilla::Plugin::Web',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Archive::Tar' => '1.52',
    'Capture::Tiny' => '0.08',
    'Data::Section' => '0.004',
    'Dist::Zilla' => '4.200015',
    'Dist::Zilla::Plugin::CheckChangesHasContent' => '0.003',
    'Dist::Zilla::Plugin::Git' => '1.112070',
    'Dist::Zilla::Plugin::GithubMeta' => '0.10',
    'Dist::Zilla::Plugin::InstallRelease' => '0.007',
    'File::Find::Rule' => '0.28',
    'File::Temp' => '0.22',
    'Getopt::LL' => '1.00',
    'JSON' => '2.53',
    'MIME::Types' => '0.00',
    'Path::Class' => '0.16',
    'Text::Markdown' => '1.0.26',
    'Text::MultiMarkdown' => '1.0.29'
  },
  'script_files' => [],
  'share_dir' => {
    'dist' => 'share'
  }
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
