\unset ECHO
\i test_setup.sql

-- $Id$

SELECT plan(14);

/****************************************************************************/

-- Set up some functions that are used only by this test, and aren't available
-- in PostgreSQL 8.2 or older

CREATE OR REPLACE FUNCTION quote_literal(polygon)
RETURNS TEXT AS 'SELECT '''''''' || textin(poly_out($1)) || '''''''''
LANGUAGE SQL IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION quote_literal(integer[])
RETURNS TEXT AS 'SELECT '''''''' || textin(array_out($1)) || '''''''''
LANGUAGE SQL IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION quote_literal(inet[])
RETURNS TEXT AS 'SELECT '''''''' || textin(array_out($1)) || '''''''''
LANGUAGE SQL IMMUTABLE STRICT;

/****************************************************************************/
-- Test cmp_ok().
\echo ok 1 - test cmp_ok( int, =, int, description )
SELECT is(
    cmp_ok( 1, '=', 1, '1 should = 1' ),
    'ok 1 - 1 should = 1',
    'cmp_ok( int, =, int, description ) should work'
);

\echo ok 3 - test cmp_ok( int, <>, int, description )
SELECT is(
    cmp_ok( 1, '<>', 2, '1 should <> 2' ),
    'ok 3 - 1 should <> 2',
    'cmp_ok( int, <>, int ) should work'
);

\echo ok 5 - test cmp_ok( polygon, ~=, polygon )
SELECT is(
    cmp_ok( '((0,0),(1,1))'::polygon, '~=', '((1,1),(0,0))'::polygon ),
    'ok 5',
    'cmp_ok( polygon, ~=, polygon ) should work'
);

\echo ok 7 - test cmp_ok( int[], =, int[] )
SELECT is(
    cmp_ok( ARRAY[1, 2], '=', ARRAY[1, 2]),
    'ok 7',
    'cmp_ok( int[], =, int[] ) should work'
);

\echo ok 9 - test cmp_ok( inet[], =, inet[] )
SELECT is(
    cmp_ok( ARRAY['192.168.1.2'::inet], '=', ARRAY['192.168.1.2'::inet] ),
    'ok 9',
    'cmp_ok( inet[], =, inet[] ) should work'
);

\echo ok 11 - Test cmp_ok() failure output
SELECT is(
    cmp_ok( 1, '=', 2, '1 should = 2' ),
    'not ok 11 - 1 should = 2
# Failed test 11: "1 should = 2"
#     ''1''
#         =
#     ''2''',
    'cmp_ok() failure output should be correct'
);

\echo ok 13 - Test cmp_ok() failure output
SELECT is(
    cmp_ok( 1, '=', NULL, '1 should = NULL' ),
    'not ok 13 - 1 should = NULL
# Failed test 13: "1 should = NULL"
#     ''1''
#         =
#     NULL',
    'cmp_ok() failure output should be correct'
);

-- Clean up the failed test results.
UPDATE __tresults__ SET ok = true, aok = true WHERE numb IN( 11, 13 );

/****************************************************************************/
-- Finish the tests and clean up.
SELECT * FROM finish();
ROLLBACK;

-- Spam fingerprints: Contains an exact font color, and the words in the title are the same as in the body.
-- rule that extracts the existing google ad ID, a string, get from original special features script.