#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set(ATOMSPACE_LIBPATH
        /usr/lib/ /usr/lib64/ /usr/local/lib/ /usr/local/lib64/)

find_library(ATOMSPACE_atombase_LIBRARY atombase
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_atomcore_LIBRARY atomcore
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_LIBRARY atomspace
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_atomspaceutils_LIBRARY atomspaceutils
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_atomutils_LIBRARY atomutils
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_attentionbank_LIBRARY attentionbank
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_clearbox_LIBRARY clearbox
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_execution_LIBRARY execution
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_lambda_LIBRARY lambda
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_persist_LIBRARY persist
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_persist-sql_LIBRARY persist-sql
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_persist-zmq_LIBRARY persist-zmq
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_PythonEval_LIBRARY PythonEval
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_query_LIBRARY query
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_ruleengine_LIBRARY ruleengine
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_smob_LIBRARY smob
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_unify_LIBRARY unify
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_truthvalue_LIBRARY truthvalue
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

find_library(ATOMSPACE_zmqatoms_LIBRARY zmqatoms
        PATH ${ATOMSPACE_LIBPATH} PATH_SUFFIXES opencog)

set(ATOMSPACE_LIBRARIES
        ${ATOMSPACE_atombase_LIBRARY}
        ${ATOMSPACE_atomcore_LIBRARY}
        ${ATOMSPACE_attentionbank_LIBRARY}
        ${ATOMSPACE_LIBRARY}
        ${ATOMSPACE_atomspaceutils_LIBRARY}
        ${ATOMSPACE_truthvalue_LIBRARY}
        ${ATOMSPACE_atomutils_LIBRARY}
        ${ATOMSPACE_clearbox_LIBRARY}
        ${ATOMSPACE_lambda_LIBRARY}
        ${ATOMSPACE_persist_LIBRARY}
        ${ATOMSPACE_query_LIBRARY}
        ${ATOMSPACE_execution_LIBRARY}
        ${ATOMSPACE_ruleengine_LIBRARY}
        ${ATOMSPACE_smob_LIBRARY}
        ${ATOMSPACE_unify_LIBRARY}
        )

# persist-sql is optional
IF (ATOMSPACE_persist-sql_LIBRARY)
    SET(ATOMSPACE_LIBRARIES
            ${ATOMSPACE_LIBRARIES}
            ${ATOMSPACE_persist-sql_LIBRARY}
            )
    SET(HAVE_PERSIST_SQL 1)
    ADD_DEFINITIONS(-DHAVE_PERSIST_SQL)
ENDIF (ATOMSPACE_persist-sql_LIBRARY)

# persist-zmq is optional
IF (ATOMSPACE_zmqatoms_LIBRARY)
    SET(ATOMSPACE_LIBRARIES
            ${ATOMSPACE_LIBRARIES}
            ${ATOMSPACE_zmqatoms_LIBRARY}
            )
ENDIF (ATOMSPACE_zmqatoms_LIBRARY)

INCLUDE (CheckIncludeFiles)

find_path(ATOMSPACE_INCLUDE_DIR opencog/atomspace/version.h
        PATH /usr/include /usr/local/include
        )

set(CMAKE_REQUIRED_INCLUDES ${ATOMSPACE_INCLUDE_DIR})
CHECK_INCLUDE_FILES (opencog/atomspace/version.h HAVE_ATOMSPACE_H)

if (ATOMSPACE_LIBRARY AND HAVE_ATOMSPACE_H)
    set(ATOMSPACE_FOUND TRUE)
    set(ATOMSPACE_VERSION 0)
    FILE(READ "${ATOMSPACE_INCLUDE_DIR}/opencog/atomspace/version.h" _CU_H_CONTENTS)
    STRING(REGEX MATCH
            "#define ATOMSPACE_VERSION_STRING[  ]+\"([0-9.]+)\""
            _MATCH "${_CU_H_CONTENTS}")
    SET(ATOMSPACE_VERSION ${CMAKE_MATCH_1})
endif (ATOMSPACE_LIBRARY AND HAVE_ATOMSPACE_H)

if ( ATOMSPACE_FOUND )
    #	message(STATUS "Found CogUtil version ${ATOMSPACE_VERSION} at ${ATOMSPACE_LIBRARY}")
    message(STATUS "Found AtomSpace at ${ATOMSPACE_LIBRARY}")
else ( ATOMSPACE_FOUND )
    message(STATUS "AtomSpace not found")
endif ( ATOMSPACE_FOUND )
