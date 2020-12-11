SET SERVEROUTPUT ON

-- 1]
DECLARE
TYPE M IS VARRAY(11) OF INTEGER NOT NULL;
A M:= M(30,40,25, 35, 45, 25, 20, 15, 10, 5, 1);
Y NUMBER(4);
BEGIN
Y := (A.count+1)/2;
DBMS_OUTPUT.PUT_LINE(A(Y));
END;
/


-- 2]
DECLARE
TYPE M IS VARRAY(10) OF INTEGER OF NOT NULL;
ARR M := M(41, 27, 37, 35, 30, 22, 25, 18, 15, 20);
NUM1 NUMBER(4,2) := 0;
NUM2 NUMBER(4);
BEGIN
NUM1 := (ARR.count+1)/2;
NUM2 := (ARR(NUM1) + ARR(NUM1-1))/2;
DBMS_OUTPUT.PUT_LINE(NUM2);
END;
/


-- 3]
DECLARE
TYPE NUMBER IS VARRAY(10) OF VARCHAR2(100) NOT NULL;
NUM  NUMBER := NUMBER('CRORE','LAKH','THOUSAND','HUNDRED','RUPEES','PAISE');
A NUMBER(10);
B NUMBER(10);
STR varchar2(100);
BEGIN
	A := &AMOUNT;
	IF A >= 10000000 THEN
		SELECT FLOOR(MOD(A, 10000000)) INTO B FROM DUAL;
		STR := NUM(1);
	END IF;
END;
/


-- 4]
CREATE OR REPLACE FUNCTION amount_in_words (i_amt in NUMBER)
   RETURN VARCHAR2
IS
   n_rupees   NUMBER;
   n_paise   NUMBER;

   FUNCTION check_if_single (i_num IN NUMBER, currency IN VARCHAR2)
      RETURN VARCHAR2
   IS
      FUNCTION n_spell (i_num IN NUMBER)
         RETURN VARCHAR2
      AS
         TYPE w_Array IS TABLE OF VARCHAR2 (255);

         l_str w_array
               := w_array (
                            ' hundred ',
                            ' thousand ',
                            ' lakh ',
                            'crores'
                           );

         l_num           VARCHAR2 (50) DEFAULT TRUNC (i_num);
         l_is_negative   BOOLEAN := FALSE;
         l_return        VARCHAR2 (4000);
      BEGIN
         IF SIGN (i_num) = -1
          THEN
            l_is_negative := TRUE;
            l_num := TRUNC (ABS (i_num));
         END IF;

         FOR i IN 1 .. l_str.COUNT
         LOOP
            EXIT WHEN l_num IS NULL;

            IF (SUBSTR (l_num, LENGTH (l_num) - 2, 3) <> 0)
            THEN
               l_return :=
                  TO_CHAR (
                     TO_DATE (SUBSTR (l_num, LENGTH (l_num) - 2, 3), 'J'),
                     'Jsp')
                  || l_str (i)
                  || l_return;
            END IF;

            l_num := SUBSTR (l_num, 1, LENGTH (l_num) - 3);
         END LOOP;

         IF NOT l_is_negative
         THEN
            RETURN INITCAP (l_return);
         ELSE
            RETURN 'Negative ' || INITCAP (l_return);
         END IF;
      END n_spell;
   BEGIN
      IF i_num = 1
      THEN
         RETURN 'One ' || currency;
      ELSE
         RETURN n_spell (i_num) || ' ' || currency;
      END IF;
   END check_if_single;
BEGIN
   IF i_amt IS NULL
   THEN
      RETURN '';
   END IF;

   n_rupees := TRUNC (i_amt);
   n_paise := (ABS (i_amt) - TRUNC (ABS (i_amt))) * 100;

   IF NVL (n_paise, 0) > 0
   THEN
      RETURN    check_if_single (n_rupees, 'Rupees')
             || ' and '
             || check_if_single (n_paise, 'Paise');
   ELSE
      RETURN check_if_single (n_rupees, 'Rupees');
   END IF; 
END amount_in_words;
/
