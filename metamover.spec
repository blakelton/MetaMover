Name: MetaMover
Version: 1.0.0
Release: 1%{?dist}
Summary: MetaMover Application
License: MIT
URL: https://github.com/blakelton/MetaMover
Source0: %{name}-%{version}.tar.gz

%description
MetaMover application.

%prep
# None

%build
# None

%install
mkdir -p %{buildroot}/usr/local/bin
cp -r package-rpm/usr/local/bin/* %{buildroot}/usr/local/bin/

%files
/usr/local/bin/*

%changelog
* Blake Azuela <blake@azuela.info> - 1.0.0-1
- Initial release.
