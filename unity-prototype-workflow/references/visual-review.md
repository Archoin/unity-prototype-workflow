# Unity Prototype Visual Review

Use this reference after screenshots or a short recording exist.

## Minimum readability checks

- The hook is visible against the background in motion and at rest.
- Fish silhouettes are visible without zooming in.
- At least some frames contain multiple visible targets.
- HUD values remain readable while gameplay is active.
- Warning and end states are visually distinct.

## What usually makes a prototype feel dead

- Large stretches of empty playfield.
- Targets too small to read on a laptop-sized or mobile-sized frame.
- Hook or player tool blending into the background.
- Score changing without visible on-screen cause.
- Good state logic with poor visual feedback.

## Tuning order

1. Visibility
   - increase size
   - increase contrast
   - improve sorting
2. Density
   - shorten spawn interval
   - raise active cap
   - keep enough targets visible
3. Pace
   - shorten downtime between actions
   - make catches legible and rewarding
4. Variety
   - ensure silhouettes and colors differ enough to read quickly

## What “fine” looks like for a calm prototype

- Not crowded every frame.
- Rarely completely empty.
- Clear player tool path.
- Clear target presence.
- Score progression that feels causally connected to visible actions.
