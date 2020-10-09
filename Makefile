BOOST_TRIE_VERSION=0.0.1

# Override this to specify dependant source files. By default all *cpp
# files will be made dependant.
ifeq ($(BOOST_TRIE_INCLUDED_SOURCES),)
BOOST_TRIE_INCLUDED_SOURCES=*.cpp
endif

# figure out "this dir"
BOOST_TRIE_DIR:=$(dir $(lastword $(MAKEFILE_LIST)))

BOOST_TRIE_BUILD_DIR=$(abspath $(BOOST_TRIE_DIR)/build)
BOOST_TRIE_INCLUDE_DIR=$(BOOST_TRIE_BUILD_DIR)/include

BOOST_TRIE_INCLUDES=-isystem $(BOOST_TRIE_INCLUDE_DIR)
# BOOST_TRIE_LIBS=

# Enable librml-ism only when part of a librml-ised Makefile
ifneq ($(get_glibc_version),)
CXX_INCLUDES += $(BOOST_TRIE_INCLUDES)
# LIBS += $(BOOST_TRIE_LIBS)
CLEAN_EXTRA += clean-boost-trie
endif

# The main artefact that comes out of the build.
BOOST_TRIE_ARTEFACT__=$(BOOST_TRIE_INCLUDE_DIR)/boost/trie/trie.hpp

.PHONY: build-boost-trie clean clean-boost-trie

$(BOOST_TRIE_ARTEFACT__): prefix=$(BOOST_TRIE_BUILD_DIR)
$(BOOST_TRIE_ARTEFACT__): version_=$(subst .,_,$(BOOST_TRIE_VERSION))
$(BOOST_TRIE_ARTEFACT__):
	mkdir -p $(prefix) && \
	mkdir -p $(BOOST_TRIE_INCLUDE_DIR) && \
	tar -C $(BOOST_TRIE_INCLUDE_DIR) \
		-xzf $(BOOST_TRIE_DIR)/boost-trie.tar.gz \
		--strip-components=1 \
		--wildcards 'Boost.Trie-master/boost/*'

clean: clean-boost-trie

clean-boost-trie:
	rm -rf $(BOOST_TRIE_BUILD_DIR)

build-boost-trie: $(BOOST_TRIE_ARTEFACT__)

$(BOOST_TRIE_INCLUDED_SOURCES): $(BOOST_TRIE_ARTEFACT__)
