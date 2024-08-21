*&---------------------------------------------------------------------*
*& Report ZHARSHA_ERI_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zharsha_eri_001.

DATA: o_olv        TYPE REF TO cl_salv_table,
      lo_columns   TYPE REF TO cl_salv_columns_table,
      lo_column    TYPE REF TO cl_salv_column_table,
      lo_fanctions TYPE REF TO cl_salv_functions_list,
      ls_color     TYPE lvc_s_colo.

START-OF-SELECTION.
SELECT * FROM sflight INTO TABLE @DATA(lt_sflight) UP TO 20 ROWS.

TRY.
    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = o_olv
      CHANGING
        t_table      = lt_sflight.
  CATCH cx_salv_msg.

ENDTRY.

CALL METHOD o_olv->get_display_settings
  RECEIVING
    value = DATA(gr_disp).

gr_disp->set_striped_pattern( value = abap_true ).
gr_disp->set_list_header( value = 'PURCHASE ORDER REPORT' ).

CALL METHOD o_olv->display.
