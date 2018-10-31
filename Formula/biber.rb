class Biber < Formula
  desc "Bibliography processing backend for biblatex"
  homepage "https://github.com/plk/biber"
  url "https://github.com/plk/biber/archive/v2.12.tar.gz"
  sha256 "7a752b9c2f418e6f419a3062e6213aff45bc402229fbc805ab9cb51afeb8c78e"

  # The Perl version required is newer than the macOS system version. Also, this
  # should be the same Perl as used by bibtex-perl.
  depends_on "perl"
  depends_on "spl/tex/bibtex-perl"

  # For XML::LibXML. See blacklist at:
  # https://github.com/shlomif/perl-XML-LibXML/blob/master/Makefile.PL
  depends_on "libxml2"

  # For Net::SSLeay.
  depends_on "openssl"

  # Here be (Perl) dragons!
  #
  # A very large number of module dependencies follows.
  #
  # Some of them are only test dependencies, but the Perl module build warnings
  # often do not distinguish them from the build or runtime dependencies.
  #
  # There's probably a better way to create this formula than manually finding
  # dependencies and listing each of them here. Assistance is welcome!

  # Text::Diff (no dependencies)
  resource "Algorithm::Diff" do
    url "https://cpan.metacpan.org/authors/id/T/TY/TYEMQ/Algorithm-Diff-1.1903.tar.gz"
    sha256 "30e84ac4b31d40b66293f7b1221331c5a50561a39d580d85004d9c1fff991751"
  end

  # biber (no dependencies)
  resource "File::Which" do
    url "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/File-Which-1.22.tar.gz"
    sha256 "e8a8ffcf96868c6879e82645db4ff9ef00c2d8a286fed21971e7280f52cf0dd4"
  end

  # biber (no dependencies)
  resource "Text::CSV_XS" do
    url "https://cpan.metacpan.org/authors/id/H/HM/HMBRAND/Text-CSV_XS-1.37.tgz"
    sha256 "20e16da9c38b0938f308c01d954f49d2c6922bac0d2d979bf2ad483fe7476ba2"
  end

  # Test::Exception (no dependencies)
  resource "Sub::Uplevel" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Sub-Uplevel-0.2800.tar.gz"
    sha256 "b4f3f63b80f680a421332d8851ddbe5a8e72fcaa74d5d1d98f3c8cc4a3ece293"
  end

  # List::MoreUtils (no dependencies)
  resource "List::MoreUtils::XS" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/List-MoreUtils-XS-0.428.tar.gz"
    sha256 "9d9fe621429dfe7cf2eb1299c192699ddebf060953e5ebdc1b4e293c6d6dd62d"
  end

  # List::MoreUtils (no dependencies)
  resource "Exporter::Tiny" do
    url "https://cpan.metacpan.org/authors/id/T/TO/TOBYINK/Exporter-Tiny-1.002001.tar.gz"
    sha256 "a82c334c02ce4b0f9ea77c67bf77738f76a9b8aa4bae5c7209d1c76453d3c48d"
  end

  # biber (no dependencies)
  resource "Lingua::Translit" do
    url "https://cpan.metacpan.org/authors/id/A/AL/ALINKE/Lingua-Translit-0.28.tar.gz"
    sha256 "113f91d8fc2c630437153a49fb7a52b023af8f6278ed96c070b1f60824b8eae1"
  end

  # (many) (no dependencies)
  resource "Try::Tiny" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.30.tar.gz"
    sha256 "da5bd0d5c903519bbf10bb9ba0cb7bcac0563882bcfe4503aee3fb143eddef6b"
  end

  # (many) (no dependencies)
  resource "Test::Needs" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Test-Needs-0.002005.tar.gz"
    sha256 "5a4f33983586edacdbe00a3b429a9834190140190dab28d0f873c394eb7df399"
  end

  # HTTP::Message (no dependencies)
  resource "LWP::MediaTypes" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/LWP-MediaTypes-6.02.tar.gz"
    sha256 "18790b0cc5f0a51468495c3847b16738f785a2d460403595001e0b932e5db676"
  end

  # IO::Socket::SSL (no dependencies)
  resource "Net::SSLeay" do
    url "https://cpan.metacpan.org/authors/id/M/MI/MIKEM/Net-SSLeay-1.85.tar.gz"
    sha256 "9d8188b9fb1cae3bd791979c20554925d5e94a138d00414f1a6814549927b0c8"
  end

  # (no dependencies)
  resource "URI" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/URI-1.74.tar.gz"
    sha256 "a9c254f45f89cb1dd946b689dfe433095404532a4543bdaab0b71ce0fdcdd53d"
  end

  # LWP::Protocol::https (no dependencies)
  resource "IO::Socket::SSL" do
    url "https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.060.tar.gz"
    sha256 "fb5b2877ac5b686a5d7b8dd71cf5464ffe75d10c32047b5570674870e46b1b8c"
  end

  # HTTP::Message (no dependencies)
  resource "IO::HTML" do
    url "https://cpan.metacpan.org/authors/id/C/CJ/CJM/IO-HTML-1.001.tar.gz"
    sha256 "ea78d2d743794adc028bc9589538eb867174b4e165d7d8b5f63486e6b828e7e0"
  end

  # HTML::Parser (no dependencies)
  resource "HTML::Tagset" do
    url "https://cpan.metacpan.org/authors/id/P/PE/PETDANCE/HTML-Tagset-3.20.tar.gz"
    sha256 "adb17dac9e36cd011f5243881c9739417fd102fce760f8de4e9be4c7131108e2"
  end

  # File::Listing, HTTP::Message (no dependencies)
  resource "HTTP::Date" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTTP-Date-6.02.tar.gz"
    sha256 "e8b9941da0f9f0c9c01068401a5e81341f0e3707d1c754f8e11f42a7e629e333"
  end

  # HTTP::Message (no dependencies)
  resource "Encode::Locale" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/Encode-Locale-1.05.tar.gz"
    sha256 "176fa02771f542a4efb1dbc2a4c928e8f4391bf4078473bd6040d8f11adb0ec1"
  end

  # libwww-perl (no dependencies)
  resource "Test::RequiresInternet" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MALLEN/Test-RequiresInternet-0.05.tar.gz"
    sha256 "bba7b32a1cc0d58ce2ec20b200a7347c69631641e8cae8ff4567ad24ef1e833e"
  end

  # LWP::Protocol::https (no dependencies)
  resource "Mozilla::CA" do
    url "https://cpan.metacpan.org/authors/id/A/AB/ABH/Mozilla-CA-20180117.tar.gz"
    sha256 "f2cc9fbe119f756313f321e0d9f1fac0859f8f154ac9d75b1a264c1afdf4e406"
  end

  # biber (no dependencies)
  resource "Encode::JIS2K" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DANKOGAI/Encode-JIS2K-0.03.tar.gz"
    sha256 "1ec84d72db39deb4dad6fca95acfcc21033f45a24d347c20f9a1a696896c35cc"
  end

  # biber (no dependencies)
  resource "Business::ISSN" do
    url "https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Business-ISSN-1.003.tar.gz"
    sha256 "1272456c19937a24bc5f9a0db9dc447043591137719ee4dc955a63be544b99d1"
  end

  # biber (no dependencies)
  resource "XML::Writer" do
    url "https://cpan.metacpan.org/authors/id/J/JO/JOSEPHW/XML-Writer-0.625.tar.gz"
    sha256 "e080522c6ce050397af482665f3965a93c5d16f5e81d93f6e2fe98084ed15fbe"
  end

  # MIME::Charset (no dependencies)
  resource "POD2::Base" do
    url "https://cpan.metacpan.org/authors/id/F/FE/FERREIRA/POD2-Base-0.043.tar.gz"
    sha256 "071910a2233d11767c9576f1909b8686b4696acb6a7035d1513f9c15ccf0237e"
  end

  # Encode::EUCJPASCII (no dependencies)
  resource "Encode::ISO2022" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEZUMI/Encode-ISO2022-0.04.tar.gz"
    sha256 "0452285a1629f3b5ccf43c5d2854413b1d441c1753d8c6e28b88b8b52d9b4136"
  end

  # MIME::Charset (no dependencies)
  resource "Encode::JISX0213" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEZUMI/Encode-JISX0213-0.04.tar.gz"
    sha256 "5d0b1376717c6f0af1bc5b867899d398c404a14a247cb7a81ded5924e9f830f8"
  end

  # biber (no dependencies)
  resource "Text::Roman" do
    url "https://cpan.metacpan.org/authors/id/S/SY/SYP/Text-Roman-3.5.tar.gz"
    sha256 "cb4a08a3b151802ffb2fce3258a416542ab81db0f739ee474a9583ffb73e046a"
  end

  # biber (no dependencies)
  resource "Data::Uniqid" do
    url "https://cpan.metacpan.org/authors/id/M/MW/MWX/Data-Uniqid-0.12.tar.gz"
    sha256 "b6919ba49b9fe98bfdf3e8accae7b9b7f78dc9e71ebbd0b7fef7a45d99324ccb"
  end

  # biber (no dependencies)
  resource "Regexp::Common" do
    url "https://cpan.metacpan.org/authors/id/A/AB/ABIGAIL/Regexp-Common-2017060201.tar.gz"
    sha256 "ee07853aee06f310e040b6bf1a0199a18d81896d3219b9b35c9630d0eb69089b"
  end

  # XML::SAX (no dependencies)
  resource "XML::NamespaceSupport" do
    url "https://cpan.metacpan.org/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz"
    sha256 "47e995859f8dd0413aa3f22d350c4a62da652e854267aa0586ae544ae2bae5ef"
  end

  # XML::SAX (no dependencies)
  resource "XML::SAX::Exception" do
    url "https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz"
    sha256 "66cb355ba4ef47c10ca738bd35999723644386ac853abbeb5132841f5e8a2ad0"
  end

  # Business::ISBN (no dependencies)
  resource "Business::ISBN::Data" do
    url "https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Business-ISBN-Data-20140910.003.tar.gz"
    sha256 "c756048c9b2b76ae5a7b9f1e1f6c59af670ff89b1fa574d4c3d7e4c9659685c9"
  end

  # Business::ISMN (no dependencies)
  resource "Tie::Cycle" do
    url "https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Tie-Cycle-1.225.tar.gz"
    sha256 "f330d821694af9b269b6083570d5c10ea22e6eb3b21841048ce28252b1c03d45"
  end

  # biber (no dependencies)
  resource "autovivification" do
    url "https://cpan.metacpan.org/authors/id/V/VP/VPIT/autovivification-0.18.tar.gz"
    sha256 "2d99975685242980d0a9904f639144c059d6ece15899efde4acb742d3253f105"
  end

  # List::SomeUtils::XS (no dependencies)
  resource "Test::LeakTrace" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEEJO/Test-LeakTrace-0.16.tar.gz"
    sha256 "5f089eed915f1ec8c743f6d2777c3ecd0ca01df2f7b9e10038d316952583e403"
  end

  # List::AllUtils (no dependencies)
  resource "List::UtilsBy" do
    url "https://cpan.metacpan.org/authors/id/P/PE/PEVANS/List-UtilsBy-0.11.tar.gz"
    sha256 "faddf43b4bc21db8e4c0e89a26e5f23fe626cde3491ec651b6aa338627f5775a"
  end

  # biber (no dependencies)
  resource "Data::Dump" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/Data-Dump-1.23.tar.gz"
    sha256 "af53b05ef1387b4cab4427e6789179283e4f0da8cf036e8db516ddb344512b65"
  end

  # File::Find::Rule (no dependencies)
  resource "Number::Compare" do
    url "https://cpan.metacpan.org/authors/id/R/RC/RCLAMP/Number-Compare-0.03.tar.gz"
    sha256 "83293737e803b43112830443fb5208ec5208a2e6ea512ed54ef8e4dd2b880827"
  end

  # File::Find::Rule (no dependencies)
  resource "Text::Glob" do
    url "https://cpan.metacpan.org/authors/id/R/RC/RCLAMP/Text-Glob-0.11.tar.gz"
    sha256 "069ccd49d3f0a2dedb115f4bdc9fbac07a83592840953d1fcdfc39eb9d305287"
  end

  # biber (no dependencies)
  resource "Sort::Key" do
    url "https://cpan.metacpan.org/authors/id/S/SA/SALVA/Sort-Key-1.33.tar.gz"
    sha256 "ed6a4ccfab094c9cd164f564024e98bd21d94f4312ccac4d6246d22b34081acf"
  end

  # Package::DeprecationManager (no dependencies)
  resource "Sub::Name" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Sub-Name-0.21.tar.gz"
    sha256 "bd32e9dee07047c10ae474c9f17d458b6e9885a6db69474c7a494ccc34c27117"
  end

  # Package::DeprecationManager (no dependencies)
  resource "Sub::Install" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Sub-Install-0.928.tar.gz"
    sha256 "61e567a7679588887b7b86d427bc476ea6d77fffe7e0d17d640f89007d98ef0f"
  end

  # Package::DeprecationManager (no dependencies)
  resource "Params::Util" do
    url "https://cpan.metacpan.org/authors/id/A/AD/ADAMK/Params-Util-1.07.tar.gz"
    sha256 "30f1ec3f2cf9ff66ae96f973333f23c5f558915bb6266881eac7423f52d7c76c"
  end

  # namespace::autoclean (no dependencies)
  resource "Sub::Identify" do
    url "https://cpan.metacpan.org/authors/id/R/RG/RGARCIA/Sub-Identify-0.14.tar.gz"
    sha256 "068d272086514dd1e842b6a40b1bedbafee63900e5b08890ef6700039defad6f"
  end

  # biber (no dependencies)
  resource "Log::Log4perl" do
    url "https://cpan.metacpan.org/authors/id/M/MS/MSCHILLI/Log-Log4perl-1.49.tar.gz"
    sha256 "b739187f519146cb6bebcfc427c64b1f4138b35c5f4c96f46a21ed4a43872e16"
  end

  # biber (no dependencies)
  resource "Class::Accessor" do
    url "https://cpan.metacpan.org/authors/id/K/KA/KASEI/Class-Accessor-0.51.tar.gz"
    sha256 "bf12a3e5de5a2c6e8a447b364f4f5a050bf74624c56e315022ae7992ff2f411c"
  end

  # Config::AutoConf (no dependencies)
  resource "Capture::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz"
    sha256 "6c23113e87bad393308c90a207013e505f659274736638d8c79bac9c67cc3e19"
  end

  # Exception::Class (no dependencies)
  resource "Class::Data::Inheritable" do
    url "https://cpan.metacpan.org/authors/id/T/TM/TMTM/Class-Data-Inheritable-0.08.tar.gz"
    sha256 "9967feceea15227e442ec818723163eb6d73b8947e31f16ab806f6e2391af14a"
  end

  # Eval::Closure (no dependencies)
  resource "Test::Requires" do
    url "https://cpan.metacpan.org/authors/id/T/TO/TOKUHIROM/Test-Requires-0.10.tar.gz"
    sha256 "2768a391d50ab94b95cefe540b9232d7046c13ee86d01859e04c044903222eb5"
  end

  # Specio (no dependencies)
  resource "MRO::Compat" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/MRO-Compat-0.13.tar.gz"
    sha256 "8a2c3b6ccc19328d5579d02a7d91285e2afd85d801f49d423a8eb16f323da4f8"
  end

  # Specio (no dependencies)
  resource "Role::Tiny" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Role-Tiny-2.000006.tar.gz"
    sha256 "cc73418c904a0286ecd8915eac11f5be2a8d1e17ea9cb54c9116b0340cd3e382"
  end

  # Exception::Class, Specio (no dependencies)
  resource "Devel::StackTrace" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Devel-StackTrace-2.03.tar.gz"
    sha256 "7618cd4ebe24e254c17085f4b418784ab503cb4cb3baf8f48a7be894e59ba848"
  end

  # Sub::Info, Term::Table (no dependencies)
  resource "Importer" do
    url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Importer-0.025.tar.gz"
    sha256 "0745138c487d74033d0cbeb36f06595036dc7e688f1a5dbec9cc2fa799e13946"
  end

  # Test2::Suite (no dependencies)
  resource "Module::Pluggable" do
    url "https://cpan.metacpan.org/authors/id/S/SI/SIMONW/Module-Pluggable-5.2.tar.gz"
    sha256 "b3f2ad45e4fd10b3fb90d912d78d8b795ab295480db56dc64e86b9fa75c5a6df"
  end

  # Test2::Suite (no dependencies)
  resource "Scope::Guard" do
    url "https://cpan.metacpan.org/authors/id/C/CH/CHOCOLATE/Scope-Guard-0.21.tar.gz"
    sha256 "8c9b1bea5c56448e2c3fadc65d05be9e4690a3823a80f39d2f10fdd8f777d278"
  end

  # Test2::Plugin::NoWarnings (no dependencies)
  resource "IPC::Run3" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/IPC-Run3-0.048.tar.gz"
    sha256 "3d81c3cc1b5cff69cca9361e2c6e38df0352251ae7b41e2ff3febc850e463565"
  end

  # Params::ValidationCompiler (no dependencies)
  resource "Test::Without::Module" do
    url "https://cpan.metacpan.org/authors/id/C/CO/CORION/Test-Without-Module-0.20.tar.gz"
    sha256 "8e9aeb7c32a6c6d0b8a93114db2a8c072721273a9d9a2dd4f9ca86cfd28aa524"
  end

  # CPAN::Meta::Check (no dependencies)
  resource "Test::Deep" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Test-Deep-1.128.tar.gz"
    sha256 "852d7e836fba8269b0b755082051a24a1a309d015a8b76838790af9e3760092f"
  end

  # Test::File::ShareDir (no dependencies)
  resource "Class::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Class-Tiny-1.006.tar.gz"
    sha256 "2efcbd31528be51d3022c616768558b78c6172df5f03c5dc698939f65488cb4e"
  end

  # DateTime::Locale (no dependencies)
  resource "IPC::System::Simple" do
    url "https://cpan.metacpan.org/authors/id/P/PJ/PJF/IPC-System-Simple-1.25.tar.gz"
    sha256 "f1b6aa1dfab886e8e4ea825f46a1cbb26038ef3e727fef5d84444aa8035a4d3b"
  end

  # DateTime::TimeZone (no dependencies)
  resource "Class::Singleton" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHAY/Class-Singleton-1.5.tar.gz"
    sha256 "38220d04f02e3a803193c2575a1644cce0b95ad4b95c19eb932b94e2647ef678"
  end

  # File::Copy::Recursive (no dependencies)
  resource "Path::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Path-Tiny-0.108.tar.gz"
    sha256 "3c49482be2b3eb7ddd7e73a5b90cff648393f5d5de334ff126ce7a3632723ff5"
  end

  # File::Slurper, File::Copy::Recursive (no dependencies)
  resource "Test::Warnings" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Test-Warnings-0.026.tar.gz"
    sha256 "ae2b68b1b5616704598ce07f5118efe42dc4605834453b7b2be14e26f9cc9a08"
  end

  # biber
  resource "File::Slurper" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/File-Slurper-0.012.tar.gz"
    sha256 "4efb2ea416b110a1bda6f8133549cc6ea3676402e3caf7529fce0313250aa578"
  end

  # Module::Install (no dependencies)
  resource "YAML::Tiny" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-1.73.tar.gz"
    sha256 "bc315fa12e8f1e3ee5e2f430d90b708a5dc7e47c867dba8dce3a6b8fbe257744"
  end

  # Module::Install (no dependencies)
  resource "Module::ScanDeps" do
    url "https://cpan.metacpan.org/authors/id/R/RS/RSCHUPP/Module-ScanDeps-1.25.tar.gz"
    sha256 "845ac18324d9063d93994b39803f0be4a882aad07b8ecf2a2aec9b06b005488c"
  end

  # B::Hooks::EndOfScope (no dependencies)
  resource "Sub::Exporter::Progressive" do
    url "https://cpan.metacpan.org/authors/id/F/FR/FREW/Sub-Exporter-Progressive-0.001013.tar.gz"
    sha256 "d535b7954d64da1ac1305b1fadf98202769e3599376854b2ced90c382beac056"
  end

  # B::Hooks::EndOfScope (no dependencies)
  resource "Variable::Magic" do
    url "https://cpan.metacpan.org/authors/id/V/VP/VPIT/Variable-Magic-0.62.tar.gz"
    sha256 "3f9a18517e33f006a9c2fc4f43f01b54abfe6ff2eae7322424f31069296b615c"
  end

  # Dist::CheckConflicts, Sub::Quote
  resource "Test::Fatal" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Test-Fatal-0.014.tar.gz"
    sha256 "bcdcef5c7b2790a187ebca810b0a08221a63256062cfab3c3b98685d91d1cbb0"
  end

  # Dist::CheckConflicts
  resource "Module::Runtime" do
    url "https://cpan.metacpan.org/authors/id/Z/ZE/ZEFRAM/Module-Runtime-0.016.tar.gz"
    sha256 "68302ec646833547d410be28e09676db75006f4aa58a11f3bdb44ffe99f0f024"
  end

  # DateTime::Locale
  resource "Dist::CheckConflicts" do
    url "https://cpan.metacpan.org/authors/id/D/DO/DOY/Dist-CheckConflicts-0.11.tar.gz"
    sha256 "ea844b9686c94d666d9d444321d764490b2cde2f985c4165b4c2c77665caedc4"
  end

  # DateTime::Locale
  resource "File::ShareDir::Install" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/File-ShareDir-Install-0.13.tar.gz"
    sha256 "45befdf0d95cbefe7c25a1daf293d85f780d6d2576146546e6828aad26e580f9"
  end

  # Params::ValidationCompiler, Specio
  resource "Eval::Closure" do
    url "https://cpan.metacpan.org/authors/id/D/DO/DOY/Eval-Closure-0.14.tar.gz"
    sha256 "ea0944f2f5ec98d895bef6d503e6e4a376fea6383a6bc64c7670d46ff2218cad"
  end

  # Params::ValidationCompiler
  resource "Exception::Class" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Exception-Class-1.44.tar.gz"
    sha256 "33f3fbf8b138d3b04ea4ec0ba83fb0df6ba898806bcf4ef393d4cafc1a23ee0d"
  end

  # Specio
  resource "Sub::Quote" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Sub-Quote-2.005001.tar.gz"
    sha256 "d6ab4f0775def015367a05e02024b403f991b2be11d774f3d235fe7e9bdbba07"
  end

  # Params::ValidationCompiler, DateTime::Locale
  resource "Specio" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Specio-0.42.tar.gz"
    sha256 "23298b93a26d7ae3c1d58106f5898d84ddc71b626afdbf801bddb04d5e524ef6"
  end

  # Test2::Suite
  resource "Sub::Info" do
    url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Sub-Info-0.002.tar.gz"
    sha256 "ea3056d696bdeff21a99d340d5570887d39a8cc47bff23adfc82df6758cdd0ea"
  end

  # Test2::Suite
  resource "Term::Table" do
    url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Term-Table-0.012.tar.gz"
    sha256 "4db6118fbf862bd32a8402e1ee28ce2044d0e0887ef29b726e917ab4258a063a"
  end

  # Test2::Suite
  resource "Test::Simple" do
    url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Test-Simple-1.302140.tar.gz"
    sha256 "73f5440c7ae55e13706e9ebeaa7247df973226470f028344ea3cd21e1642bd1d"
  end

  # Test2::Plugin::NoWarnings
  resource "Test2::Suite" do
    url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Test2-Suite-0.000115.tar.gz"
    sha256 "02be3428a0965aeb21245d44bbadda69b94dc76cd68d5695352c996ac7fc3638"
  end

  # Params::ValidationCompiler
  resource "Test2::Plugin::NoWarnings" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Test2-Plugin-NoWarnings-0.06.tar.gz"
    sha256 "8288c1d934f69a03224598fbb715adc079c0d1609bfbaea6c88682aab1995800"
  end

  # DateTime::Locale
  resource "Params::ValidationCompiler" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Params-ValidationCompiler-0.30.tar.gz"
    sha256 "dc5bee23383be42765073db284bed9fbd819d4705ad649c20b644452090d16cb"
  end

  # DateTime::Locale
  resource "CPAN::Meta::Check" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/CPAN-Meta-Check-0.014.tar.gz"
    sha256 "28a0572bfc1c0678d9ce7da48cf521097ada230f96eb3d063fcbae1cfe6a351f"
  end

  # File::ShareDir
  resource "Class::Inspector" do
    url "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Class-Inspector-1.32.tar.gz"
    sha256 "cefadc8b5338e43e570bc43f583e7c98d535c17b196bcf9084bb41d561cc0535"
  end

  # Test::File::ShareDir
  resource "File::ShareDir" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/File-ShareDir-1.116.tar.gz"
    sha256 "59d90bfdf98c4656ff4173e62954ea8cf0de66565e35d108ecd7050596cb8328"
  end

  # Module::Install
  resource "File::Remove" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/File-Remove-1.58.tar.gz"
    sha256 "81f6ec83acab8ba042afe904334a26eb3a56c217bdb9981d237a89ab072fd0d8"
  end

  # Test::utf8, Encode::HanExtra
  resource "Module::Install" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Module-Install-1.19.tar.gz"
    sha256 "1a53a78ddf3ab9e3c03fc5e354b436319a944cba4281baf0b904fa932a13011b"
  end

  # Test::File
  resource "Test::utf8" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MARKF/Test-utf8-1.01.tar.gz"
    sha256 "ef371b1769cd8d36d2d657e8321723d94c8f8d89e7fd7437c6648c5dc6711b7a"
  end

  # File::Copy::Recursive
  resource "Test::File" do
    url "https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Test-File-1.443.tar.gz"
    sha256 "61b4a6ab8f617c8c7b5975164cf619468dc304b6baaaea3527829286fa58bcd5"
  end

  # Test::File::ShareDir
  resource "File::Copy::Recursive" do
    url "https://cpan.metacpan.org/authors/id/D/DM/DMUEY/File-Copy-Recursive-0.44.tar.gz"
    sha256 "ae19a0b58dc1b3cded9ba9cfb109288d8973d474c0b4bfd28b27cf60e8ca6ee4"
  end

  # DateTime::Locale
  resource "Test::File::ShareDir" do
    url "https://cpan.metacpan.org/authors/id/K/KE/KENTNL/Test-File-ShareDir-1.001002.tar.gz"
    sha256 "b33647cbb4b2f2fcfbde4f8bb4383d0ac95c2f89c4c5770eb691f1643a337aad"
  end

  # B::Hooks::EndOfScope
  resource "Module::Implementation" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Module-Implementation-0.09.tar.gz"
    sha256 "c15f1a12f0c2130c9efff3c2e1afe5887b08ccd033bd132186d1e7d5087fd66d"
  end

  # namespace::autoclean
  resource "B::Hooks::EndOfScope" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/B-Hooks-EndOfScope-0.24.tar.gz"
    sha256 "03aa3dfe5d0aa6471a96f43fe8318179d19794d4a640708f0288f9216ec7acc6"
  end

  # Package::Stash
  resource "Package::Stash::XS" do
    url "https://cpan.metacpan.org/authors/id/D/DO/DOY/Package-Stash-XS-0.28.tar.gz"
    sha256 "23d8c5c25768ef1dc0ce53b975796762df0d6e244445d06e48d794886c32d486"
  end

  # namespace::clean, Package::DeprecationManager
  resource "Package::Stash" do
    url "https://cpan.metacpan.org/authors/id/D/DO/DOY/Package-Stash-0.37.tar.gz"
    sha256 "06ab05388f9130cd377c0e1d3e3bafeed6ef6a1e22104571a9e1d7bfac787b2c"
  end

  # namespace::autoclean
  resource "namespace::clean" do
    url "https://cpan.metacpan.org/authors/id/R/RI/RIBASUSHI/namespace-clean-0.27.tar.gz"
    sha256 "8a10a83c3e183dc78f9e7b7aa4d09b47c11fb4e7d3a33b9a12912fd22e31af9d"
  end

  # DateTime::Locale
  resource "namespace::autoclean" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/namespace-autoclean-0.28.tar.gz"
    sha256 "cd410a1681add521a28805da2e138d44f0d542407b50999252a147e553c26c39"
  end

  # DateTime
  resource "DateTime::Locale" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/DateTime-Locale-1.23.tar.gz"
    sha256 "3a5a81e742da96d89b408e40f8bf4b21150663d8a5eb9dad7865db582193c015"
  end

  # DateTime
  resource "DateTime::TimeZone" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/DateTime-TimeZone-2.20.tar.gz"
    sha256 "6b69cb9406f7fd2f9ef452996de62686f0b8563469a7e7438fd2bf37735a2829"
  end

  # DateTime::Format::Builder
  resource "DateTime" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/DateTime-1.50.tar.gz"
    sha256 "ed6b0c71ddd81310a82459508df9197074e6b13aea46fd279045c3ddc3c4b198"
  end

  # DateTime::Format::Strptime
  resource "Package::DeprecationManager" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Package-DeprecationManager-0.17.tar.gz"
    sha256 "1d743ada482b5c9871d894966e87d4c20edc96931bb949fb2638b000ddd6684b"
  end

  # DateTime::Format::Builder
  resource "DateTime::Format::Strptime" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/DateTime-Format-Strptime-1.75.tar.gz"
    sha256 "4fcfb2ac4f79d7ff2855a405f39050d2ea691ee098ce54ede8af79c8d6ab3c19"
  end

  # DateTime::Format::Builder
  resource "Params::Validate" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Params-Validate-1.29.tar.gz"
    sha256 "49a68dfb430bea028042479111d19068e08095e5a467e320b7ab7bde3d729733"
  end

  # DateTime::Format::Builder
  resource "Class::Factory::Util" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Class-Factory-Util-1.7.tar.gz"
    sha256 "6c516b445b44f87363fb3a148431d31e9ecb5e6f21fb6481c89b2406b6692e26"
  end

  # biber
  resource "DateTime::Format::Builder" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/DateTime-Format-Builder-0.81.tar.gz"
    sha256 "7cd58a8cb53bf698407cc992f89e4d49bf3dc55baf4f3f00f1def63a0fff33ef"
  end

  # biber
  resource "DateTime::Calendar::Julian" do
    url "https://cpan.metacpan.org/authors/id/P/PI/PIJLL/DateTime-Calendar-Julian-0.04.tar.gz"
    sha256 "bb5968ad18bcd0772d2c311cd2deb23b777475ea05aa1099688247cd27a5000e"
  end

  # biber
  resource "Text::CSV" do
    url "https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-1.97.tar.gz"
    sha256 "cc350462efa8d39d5c8a1da5f205bc31620cd52d9865a769c8e3ed1b41640fd5"
  end

  # Data::Compare
  resource "File::Find::Rule" do
    url "https://cpan.metacpan.org/authors/id/R/RC/RCLAMP/File-Find-Rule-0.34.tar.gz"
    sha256 "7e6f16cc33eb1f29ff25bee51d513f4b8a84947bbfa18edb2d3cc40a2d64cafe"
  end

  # biber
  resource "Data::Compare" do
    url "https://cpan.metacpan.org/authors/id/D/DC/DCANTRELL/Data-Compare-1.25.tar.gz"
    sha256 "1d4b36db545fa9fbacd8c012618f6a7846238ee12ab627a2764cfaf45ad4ea73"
  end

  # List::SomeUtils
  resource "List::SomeUtils::XS" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/List-SomeUtils-XS-0.58.tar.gz"
    sha256 "4f9e4d2622481b79cc298e8e29de8a30943aff9f4be7992c0ebb7b22e5b4b297"
  end

  # List::AllUtils
  resource "List::SomeUtils" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/List-SomeUtils-0.56.tar.gz"
    sha256 "eaa7d99ce86380c0389876474c8eb84acc0a6bfeef1b0fc23a292592de6f89f7"
  end

  # biber
  resource "List::AllUtils" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/List-AllUtils-0.14.tar.gz"
    sha256 "e45aa65927ae1975a000cc2fed14274627fa5e2bd09bab826a5f2c41d17ef6cd"
  end

  # biber
  resource "Business::ISBN" do
    url "https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Business-ISBN-3.004.tar.gz"
    sha256 "31754acd57bf0c3d4762003d784bce4a0af6832a725336e219fb2988b6fb831e"
  end

  # biber
  resource "Business::ISMN" do
    url "https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Business-ISMN-1.201.tar.gz"
    sha256 "4a3231a16456bf8cbf17f26b65243f247078b5145d9a03aa7586baf09577ecb2"
  end

  # XML::LibXML
  resource "XML::SAX" do
    url "https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.00.tar.gz"
    sha256 "45ea6564ef8692155d57b2de0862b6442d3c7e29f4a9bc9ede5d7ecdc74c2ae3"
  end

  # XML::LibXML::Simple, XML::LibXSLT
  resource "XML::LibXML" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/XML-LibXML-2.0132.tar.gz"
    sha256 "721452e3103ca188f5968ab06d5ba29fe8e00e49f4767790882095050312d476"
  end

  # biber
  resource "XML::LibXML::Simple" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MARKOV/XML-LibXML-Simple-0.99.tar.gz"
    sha256 "14fe45c9fcb36c1cf14ac922da4439f1f83d451a5e70aa7177cb6edb705c9e44"
  end

  # biber
  resource "XML::LibXSLT" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/XML-LibXSLT-1.96.tar.gz"
    sha256 "2a5e374edaa2e9f9d26b432265bfea9b4bb7a94c9fbfef9047b298fce844d473"
  end

  # MIME::Charset
  resource "Encode::EUCJPASCII" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEZUMI/Encode-EUCJPASCII-0.03.tar.gz"
    sha256 "f998d34d55fd9c82cf910786a0448d1edfa60bf68e2c2306724ca67c629de861"
  end

  # MIME::Charset
  resource "Encode::HanExtra" do
    url "https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Encode-HanExtra-0.23.tar.gz"
    sha256 "1fd4b06cada70858003af153f94c863b3b95f2e3d03ba18d0451a81d51db443a"
  end

  # Unicode::GCString
  resource "MIME::Charset" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEZUMI/MIME-Charset-1.012.2.tar.gz"
    sha256 "878c779c0256c591666bd06c0cde4c0d7820eeeb98fd1183082aee9a1e7b1d13"
  end

  # biber
  resource "Unicode::GCString" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEZUMI/Unicode-LineBreak-2018.003.tar.gz"
    sha256 "860c92ff3e710f0a1ca3e7067dba3734540dfb5cb932936536225f7ffca571b1"
  end

  # libwww-perl
  resource "File::Listing" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/File-Listing-6.04.tar.gz"
    sha256 "1e0050fcd6789a2179ec0db282bf1e90fb92be35d1171588bd9c47d52d959cf5"
  end

  # libwww-perl
  resource "HTML::Parser" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTML-Parser-3.72.tar.gz"
    sha256 "ec28c7e1d9e67c45eca197077f7cdc41ead1bb4c538c7f02a3296a4bb92f608b"
  end

  # HTTP::Cookies, HTTP::Daemon, HTTP::Negotiate
  resource "HTTP::Message" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.18.tar.gz"
    sha256 "d060d170d388b694c58c14f4d13ed908a2807f0e581146cef45726641d809112"
  end

  # libwww-perl
  resource "HTTP::Cookies" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Cookies-6.04.tar.gz"
    sha256 "0cc7f079079dcad8293fea36875ef58dd1bfd75ce1a6c244cd73ed9523eb13d4"
  end

  # libwww-perl
  resource "HTTP::Daemon" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTTP-Daemon-6.01.tar.gz"
    sha256 "43fd867742701a3f9fcc7bd59838ab72c6490c0ebaf66901068ec6997514adc2"
  end

  # libwww-perl
  resource "WWW::RobotRules" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/WWW-RobotRules-6.02.tar.gz"
    sha256 "46b502e7a288d559429891eeb5d979461dd3ecc6a5c491ead85d165b6e03a51e"
  end

  # libwww-perl
  resource "Net::HTTP" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.18.tar.gz"
    sha256 "7e42df2db7adce3e0eb4f78b88c450f453f5380f120fd5411232e03374ba951c"
  end

  # LWP::Protocol::https
  resource "HTTP::Negotiate" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTTP-Negotiate-6.01.tar.gz"
    sha256 "1c729c1ea63100e878405cda7d66f9adfd3ed4f1d6cacaca0ee9152df728e016"
  end

  # LWP::Protocol::https
  resource "libwww-perl" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/libwww-perl-6.36.tar.gz"
    sha256 "75c034ab4b37f4b9506dc644300697505582cf9545bcf2e2079e7263f675290a"
  end

  # LWP::Protocol::https
  resource "Net::HTTPS" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.18.tar.gz"
    sha256 "7e42df2db7adce3e0eb4f78b88c450f453f5380f120fd5411232e03374ba951c"
  end

  # biber
  resource "LWP::Protocol::https" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.07.tar.gz"
    sha256 "522cc946cf84a1776304a5737a54b8822ec9e79b264d0ba0722a70473dbfb9e7"
  end

  # biber
  resource "List::MoreUtils" do
    url "https://cpan.metacpan.org/authors/id/R/RE/REHSACK/List-MoreUtils-0.428.tar.gz"
    sha256 "713e0945d5f16e62d81d5f3da2b6a7b14a4ce439f6d3a7de74df1fd166476cc2"
  end

  # PerlIO::utf8_strict
  resource "Test::Exception" do
    url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Test-Exception-0.43.tar.gz"
    sha256 "156b13f07764f766d8b45a43728f2439af81a3512625438deab783b7883eb533"
  end

  # biber
  resource "PerlIO::utf8_strict" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/PerlIO-utf8_strict-0.007.tar.gz"
    sha256 "83a33f2fe046cb3ad6afc80790635a423e2c7c6854afacc6998cd46951cc81cb"
  end

  # Test::Differences
  resource "Text::Diff" do
    url "https://cpan.metacpan.org/authors/id/N/NE/NEILB/Text-Diff-1.45.tar.gz"
    sha256 "e8baa07b1b3f53e00af3636898bbf73aec9a0ff38f94536ede1dbe96ef086f04"
  end

  # biber
  resource "Test::Differences" do
    url "https://cpan.metacpan.org/authors/id/D/DC/DCANTRELL/Test-Differences-0.64.tar.gz"
    sha256 "9f459dd9c2302a0a73e2f5528a0ce7d09d6766f073187ae2c69e603adf2eb276"
  end

  # TODO: Leaving this here for now in case we want to use it.

  # Test::MockModule
  #resource "SUPER" do
  #  url "https://cpan.metacpan.org/authors/id/C/CH/CHROMATIC/SUPER-1.20141117.tar.gz"
  #  sha256 "1a620e7d60aee9b13b1b26a44694c43fdb2bba1755cfff435dae83c7d42cc0b2"
  #end

  # Archive::Zip
  #resource "Test::MockModule" do
  #  url "https://cpan.metacpan.org/authors/id/G/GF/GFRANKS/Test-MockModule-v0.170.0.tar.gz"
  #  sha256 "9f79ba975cb049e1e807c36de1a31126079fffc4f22ee81526641a8969e6ef5d"
  #end

  # PAR (no dependencies)
  #resource "PAR::Dist" do
  #  url "https://cpan.metacpan.org/authors/id/R/RS/RSCHUPP/PAR-Dist-0.49.tar.gz"
  #  sha256 "9e47220b594a27bd1750bcfa1d6f60a57ae670c68ce331895a79f08bac671e1d"
  #end

  # PAR
  #resource "Archive::Zip" do
  #  url "https://cpan.metacpan.org/authors/id/P/PH/PHRED/Archive-Zip-1.64.tar.gz"
  #  sha256 "de5f84f2148038363d557b1fa33f58edc208111f789f7299fe3d8f6e11b4d17d"
  #end

  # biber
  #resource "PAR" do
  #  url "https://cpan.metacpan.org/authors/id/R/RS/RSCHUPP/PAR-1.015.tar.gz"
  #  sha256 "7d47e4b229739601f013b3043a680501cb9da48d8887d8d5d622a862a2115f46"
  #end

  def testdata
    prefix/"test"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    # WARNING!
    #   The path below is hardcoded. When the bibtex-perl formula version
    #   changes, this must also change.
    ENV.prepend_path "PERL5LIB", "/usr/local/Cellar/bibtex-perl/0.85/libexec/lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"

    # Tell IO::Socket::SSL to not run tests during build
    ENV["NO_NETWORK_TESTING"] = "1"

    resources.each do |r|
      r.stage do
        perl_build(r.name)
      end
    end

    perl_build("biber")
    (bin/"biber").write_env_script(libexec/"bin/biber", :PERL5LIB => ENV["PERL5LIB"])

    # Save a file for the test.
    testdata.install Dir["t/tdata/full-bbl.{bbl,bcf,bib}"]
  end

  test do
    # biber needs to be able to write to the source file (full-bbl.bcf) to
    # update the Unicode NFC boundary, so we copy the files locally before the
    # test. See https://github.com/plk/biber/blob/8ebedab/lib/Biber.pm#L323
    cp Dir[testdata/"full-bbl.{bcf,bib}"], testpath
    # The PDF doc recommends these flags.
    system bin/"biber", "--validate-control", "--convert-control", "full-bbl.bcf"
    assert compare_file testdata/"full-bbl.bbl", "full-bbl.bbl"
  end

  private

  def perl_build(target)
    if File.exist? "Makefile.PL"
      # Net::SSLeay requires input to generate the Makefile. We use `yes ''` to
      # hit enter at each prompt and give default answers.
      yes_pipe = target == "Net::SSLeay" ? "yes '' | " : ""
      system "#{yes_pipe}perl Makefile.PL INSTALL_BASE=#{libexec}"
      system "make", "PERL5LIB=#{ENV["PERL5LIB"]}"
      system "make", "install"
    elsif File.exist? "Build.PL"
      system "perl", "Build.PL", "--install_base", libexec
      system "./Build", "PERL5LIB=#{ENV["PERL5LIB"]}"
      system "./Build", "install"
    else
      raise "Unknown build system for #{target}"
    end
  end

end
