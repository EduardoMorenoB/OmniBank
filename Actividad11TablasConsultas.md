# OmniBank — Actividad 11

## Reporte de cuentas

| ID de cuenta | Número de cuenta | Activa | Titular | Email | Etiqueta |
|---|---|---:|---|---|---|
| `aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa` | `ACCT-1001` | Sí | John | john.doe@email.com | `JOHN-1001` |
| `eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee` | `ACCT-1002` | No | John | john.doe@email.com | `JOHN-1002` |
| `bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb` | `ACCT-2001` | Sí | Jane | jane.smith@email.com | `JANE-2001` |
| `cccccccc-cccc-cccc-cccc-cccccccccccc` | `ACCT-3001` | Sí | Alice | alice.j@email.com | `ALICE-3001` |
| `dddddddd-dddd-dddd-dddd-dddddddddddd` | `ACCT-3002` | Sí | Alice | alice.j@email.com | `ALICE-3002` |

El reporte contiene cinco cuentas. La cuenta `ACCT-1002` está desactivada (`is_active = false`); se conserva en el reporte porque su estado no significa que carezca de movimientos.

## Nota temporal

El corte de referencia para calcular la antigüedad es `2026-10-01 00:00+00`.

Cálculo manual de fecha de revisión: `2026-09-01 10:00+00` + 15 días = `2026-09-16 10:00+00`.

## Reporte de movimientos

| ID de movimiento | ID de cuenta | Marca original (`tx_timestamp`) | Importe | Fecha de revisión |
|---|---|---|---:|---|
| `10000000-0000-0000-0000-000000000001` | `aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa` | `2026-09-01 10:00:00+00` | 150.00 | `2026-09-16 10:00:00+00` |
| `10000000-0000-0000-0000-000000000002` | `bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb` | `2026-09-02 10:00:00+00` | 300.00 | `2026-09-17 10:00:00+00` |
| `10000000-0000-0000-0000-000000000003` | `aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa` | `2026-09-03 10:00:00+00` | 50.00 | `2026-09-18 10:00:00+00` |
| `10000000-0000-0000-0000-000000000004` | `cccccccc-cccc-cccc-cccc-cccccccccccc` | `2026-09-04 10:00:00+00` | 300.00 | `2026-09-19 10:00:00+00` |

El reporte contiene cuatro movimientos. Estas filas muestran la marca original y la fecha derivada. Para completar el contrato de la consulta, todavía deben proyectarse el año y mes extraídos, la antigüedad calculada con el corte fijo y el importe transformado para presentación.
