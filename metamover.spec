Name: MetaMover
Version: 1.0.0
Release: 1%{?dist}
Summary: MetaMover Application
License: MIT
URL: https://github.com/blakelton/MetaMover

%description
MetaMover application.

%prep
# Package is prebuilt - no %setup needed

%build
# Executable is already created - skipping

%install
mkdir -p %{buildroot}/usr/local/bin
cp -a %{_myworkspace}/%{_mybuilddir}/MetaMover %{buildroot}/usr/local/bin/

%files
/usr/local/bin/MetaMover

%changelog
* Wed Jan 08 2025 Blake Azuela <blake@azuela.info> - 1.0.0-1
- Initial release.
