# Unity Prototype Visual Review

Use this reference after screenshots or a short recording exist.

## Minimum readability checks

- The player avatar, tool, or focus object is visible against the background in motion and at rest.
- Targets, enemies, pickups, or hazards are readable without zooming in.
- At least some frames contain multiple visible points of interest when the game is meant to feel active.
- HUD values remain readable while gameplay is active.
- Warning and end states are visually distinct.

## What usually makes a prototype feel dead

- Large stretches of empty playfield.
- Important interactables too small to read on a laptop-sized or mobile-sized frame.
- The player avatar, tool, or focus object blending into the background.
- Score changing without visible on-screen cause.
- Good state logic with poor visual feedback.

## Tuning order

1. Visibility
   - increase size
   - increase contrast
   - improve sorting
2. Density
   - shorten spawn interval
   - raise active cap or parallel activity
   - keep enough visible points of interest on screen
3. Pace
   - shorten downtime between actions
   - make hits, pickups, captures, or other meaningful interactions legible and rewarding
4. Variety
   - ensure silhouettes and colors differ enough to read quickly

## What “fine” looks like for a calm prototype

- Not crowded every frame.
- Rarely completely empty.
- Clear player motion or tool path.
- Clear target, obstacle, or opportunity presence.
- Progression that feels causally connected to visible actions.
