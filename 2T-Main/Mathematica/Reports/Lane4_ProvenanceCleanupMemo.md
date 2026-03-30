# Lane 4 Provenance Cleanup Memo

Date: `2026-03-29`

This memo records the provenance and imported-reference cleanup performed in lane 4 on the current
UOM-to-Main interface package.

## Owned-file cleanup completed

- `UOM/2T_Main_interface.tex`
  - clarified that the promotion note contributes manuscript-level status remarks, not theorem-backed
    promotion claims;
  - separated exact-family promotion audit support into the report lane
    `Main/Mathematica/Reports/DelayedSelectedLineAssumptionDischarge.md`;
  - made the selected-line ledger wording explicit that the exact-family audit does not by itself
    close the manuscript-level promotion boundary.

- `UOM/delayed_selected_line_promotion_note.tex`
  - retained the historical labels used by the audit and interface note;
  - clarified in-note that the extractor/kernel/survival labels currently name status remarks, not
    theorem environments;
  - recorded that the stronger March 21 branch-family results belong to the exact-certificate lane,
    not to manuscript-level theorem-backed text.

## Residual issues outside lane 4 write scope

- The `main-def:*` imported-reference convention comes from
  `UOM/odd_transport_fragment_standalone_preamble.tex`, which sets
  `\externaldocument[main-]{UOM/main}`.
  The corresponding note-cluster cleanup would require edits in
  `UOM/canonical_odd_interface_note.tex`,
  `UOM/active_response_transport_program_note.tex`,
  and `UOM/odd_selector_note.tex`, which are outside this lane's write set.

- The historical theorem-style labels in `UOM/delayed_selected_line_promotion_note.tex`
  (`thm:micro-to-seam-extractor`, `thm:universal-promoted-selected-survival`, and related labels)
  are still used by current reports and interface references.
  Renaming those labels cleanly would require synchronized edits in report text and possibly audit
  drivers outside this lane's ownership.

- `Main/Mathematica/Reports/DelayedSelectedLineAssumptionDischarge.md` still lists several
  promotion-lane labels under the `theorem-backed text` column even though the TeX file currently
  houses those labels on status remarks rather than theorem environments.
  Lane 4 cleanup made that distinction explicit in the owned TeX, but normalizing the report wording
  itself is outside this lane's write scope.
