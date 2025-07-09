# Plot Examples for max_window Truncation Fix

This directory contains visual demonstrations of the fix implemented for issue #62.

## Files

- `comparison_before_after.png` - Side-by-side comparison showing the fix in action
- `before_fix_simple.png` - Shows problematic behavior (incomplete rolling windows included)  
- `after_fix_simple.png` - Shows fixed behavior (incomplete rolling windows truncated)
- `before_fix.png` - Original complex example (partial)

## The Fix

The fix addresses the issue where the first `max_window` weeks in plot outputs contain incomplete rolling window calculations. For example, with `max_window=4`, a person needs 4 consecutive weeks of activity to be classified as 'habitual', making the first 4 weeks misleading in visualizations.

**Before Fix**: Shows all periods including incomplete rolling calculations  
**After Fix**: Truncates first `max_window` periods from plot output only (data output unchanged)

This provides cleaner, more meaningful visualizations while maintaining full data integrity.