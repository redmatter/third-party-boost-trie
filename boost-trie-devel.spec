%{!?__build_pkg_version: %define __build_pkg_version 0.0.1}
%{!?__build_pkg_release: %define __build_pkg_release 1}

%define version 0.0.1

Summary:    Boost Trie data structure 
Name:       boost-trie-devel
Version:    %{__build_pkg_version}
Release:    %{__build_pkg_release}%{?dist}
License:    Boost Software License
Group:      Development/Libraries
URL:        https://github.com/ithlony/Boost.Trie
Source0:    boost-trie.tar.gz
BuildRoot:  %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
Requires:	boost-devel

%description
RedMatter C++ wrapper and Makefile formula

%prep
%setup -q -n Boost.Trie-master

%build
chmod -x $( find . -type f )

%install
rm -rf %{buildroot}
%{__mkdir_p} %{buildroot}%{_includedir}
cp -r boost %{buildroot}%{_includedir}/.

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%{_includedir}/boost

