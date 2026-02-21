# AIRS Results Visualization Specification

**Version**: 1.0.0
**Created**: 2025-12-23
**Purpose**: Define UI specifications for individual assessment results

---

## Overview

The results page displays three primary visualizations:
1. **AIRS Gauge** — Overall AIRS Score
2. **Construct Radar Chart** — 8-construct profile visualization
3. **Typology Badge** — Classification with actionable context

---

## 1. AIRS Gauge

### Purpose
Display the user's overall AIRS Score (8-40) with clear typology mapping.

### Design Specifications

```
┌────────────────────────────────────────────────────────────────┐
│                                                                │
│                         YOUR AI READINESS                      │
│                                                                │
│                    ┌─────────────────────┐                     │
│                    │                     │                     │
│              ══════╪═══════════════════════════════            │
│            8      20        30          40                     │
│          [RED]  [YELLOW]  [GREEN]                              │
│                    │                     │                     │
│                    │    ▲                │                     │
│                    │   27                │                     │
│                    └─────────────────────┘                     │
│                                                                │
│                     MODERATE USER                              │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

### Technical Specifications

| Property | Value |
|----------|-------|
| Min Value | 8 |
| Max Value | 40 |
| Typology Zones | 8-20 (Skeptic), 21-30 (Moderate), 31-40 (Enthusiast) |
| Zone Colors | Red (#ef4444), Yellow (#f59e0b), Green (#10b981) |
| Score Indicator | Needle or triangle marker |
| Animation | Smooth ease-out on load (1s duration) |

### Color Gradient Stops

| Position | Color | Label |
|----------|-------|-------|
| 0% (8) | #ef4444 (Red) | AI Skeptic Zone |
| 37.5% (20) | #f59e0b (Yellow) | Transition |
| 68.75% (30) | #10b981 (Green) | Transition |
| 100% (40) | #22c55e (Bright Green) | AI Enthusiast Zone |

### React Component Interface

```typescript
interface AIRSGaugeProps {
  score: number;           // 8-40
  typology: 'skeptic' | 'moderate' | 'enthusiast';
  showAnimation?: boolean; // default true
  size?: 'sm' | 'md' | 'lg'; // default 'md';
}
```

---

## 2. Construct Radar Chart

### Purpose
Visualize the user's profile across all 8 AIRS constructs, highlighting strengths and areas for development.

### Design Specifications

```
                            PE (4.2)
                              ●
                            / | \
                     TR   /  |  \   EE
                    (3.8)●   |   ●(4.5)
                        /    |    \
                       /     |     \
                 HB   /      |      \   SI
                (2.1)●───────●───────●(3.5)
                      \      |      /
                       \     |     /
                    PV  \    |    /  FC
                   (4.8)●    |   ●(3.2)
                          \  |  /
                           \ | /
                             ●
                           HM (4.0)
```

### Technical Specifications

| Property | Value |
|----------|-------|
| Axes | 8 (one per construct) |
| Scale | 1-5 (Likert mean) |
| Grid Circles | 3 (at 2, 3, 4) or 5 (at 1, 2, 3, 4, 5) |
| Fill | Semi-transparent gradient (#3b82f6 at 20% opacity) |
| Stroke | Solid gradient line (#3b82f6 to #8b5cf6) |
| Data Points | Filled circles at each vertex |
| Labels | Construct abbreviation + score |

### Axis Order (Clockwise from Top)

| Position | Construct | Full Name |
|----------|-----------|-----------|
| 12 o'clock | PE | Performance Expectancy |
| 1:30 | EE | Effort Expectancy |
| 3 o'clock | SI | Social Influence |
| 4:30 | FC | Facilitating Conditions |
| 6 o'clock | HM | Hedonic Motivation |
| 7:30 | PV | Price Value |
| 9 o'clock | HB | Habit |
| 10:30 | TR | AI Trust |

### Key Predictor Highlighting

Highlight the three significant predictors (PV, HM, SI) with:
- **Bold labels** or accent color
- **Star icon** (⭐) next to label
- **Tooltip**: "Key predictor of AI adoption"

| Construct | Significance | Visual Treatment |
|-----------|--------------|------------------|
| PV | β=.505, p<.001 | ⭐ Gold highlight |
| HM | β=.217, p=.014 | ⭐ Gold highlight |
| SI | β=.136, p=.024 | ⭐ Gold highlight |
| Others | Not significant | Standard styling |

### React Component Interface

```typescript
interface ConstructRadarProps {
  constructs: {
    PE: number; // 1-5
    EE: number;
    SI: number;
    FC: number;
    HM: number;
    PV: number;
    HB: number;
    TR: number;
  };
  highlightPredictors?: boolean; // default true
  showScores?: boolean;          // default true
  size?: 'sm' | 'md' | 'lg';     // default 'md'
}
```

### Recharts Implementation Notes

```typescript
// Radar chart data format for Recharts
const radarData = [
  { construct: 'PE', score: 4.2, fullName: 'Performance Expectancy' },
  { construct: 'EE', score: 4.5, fullName: 'Effort Expectancy' },
  { construct: 'SI', score: 3.5, fullName: 'Social Influence', isPredictor: true },
  { construct: 'FC', score: 3.2, fullName: 'Facilitating Conditions' },
  { construct: 'HM', score: 4.0, fullName: 'Hedonic Motivation', isPredictor: true },
  { construct: 'PV', score: 4.8, fullName: 'Price Value', isPredictor: true },
  { construct: 'HB', score: 2.1, fullName: 'Habit' },
  { construct: 'TR', score: 3.8, fullName: 'AI Trust' },
];
```

---

## 3. Typology Badge

### Purpose
Display the user's classification with brief description and visual identity.

### Design Specifications

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │  🔴  AI SKEPTIC                                          │  │
│   │      Score: 18 / 40                                      │  │
│   │                                                          │  │
│   │  You're cautious about AI adoption and may have          │  │
│   │  concerns about trust, effort, or value. That's okay —   │  │
│   │  17% of professionals share your perspective.            │  │
│   └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │  🟡  MODERATE USER                                       │  │
│   │      Score: 27 / 40                                      │  │
│   │                                                          │  │
│   │  You're a pragmatic AI user who sees value but remains   │  │
│   │  selective. You're in good company — 67% of              │  │
│   │  professionals share your balanced approach.             │  │
│   └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │  🟢  AI ENTHUSIAST                                       │  │
│   │      Score: 35 / 40                                      │  │
│   │                                                          │  │
│   │  You're highly ready for AI adoption with strong         │  │
│   │  positive attitudes across all dimensions. You're        │  │
│   │  among the 16% leading AI adoption in the workforce.     │  │
│   └─────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Badge Styling

| Typology | Color | Icon | Border |
|----------|-------|------|--------|
| AI Skeptic | Red (#ef4444) | 🔴 or Shield | 2px solid red |
| Moderate User | Yellow (#f59e0b) | 🟡 or Scale | 2px solid yellow |
| AI Enthusiast | Green (#10b981) | 🟢 or Rocket | 2px solid green |

### React Component Interface

```typescript
interface TypologyBadgeProps {
  typology: 'skeptic' | 'moderate' | 'enthusiast';
  score: number;
  showDescription?: boolean;  // default true
  showPercentage?: boolean;   // default true
  variant?: 'card' | 'inline' | 'compact';
}
```

---

## 4. Results Page Layout

### Desktop Layout (≥1024px)

```
┌─────────────────────────────────────────────────────────────────────────┐
│  AIRS Enterprise                                        [Profile] [Logout]│
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  YOUR AI READINESS RESULTS                                              │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  ┌─────────────────────────────┐  ┌─────────────────────────────────┐  │
│  │                             │  │                                 │  │
│  │      [AIRS GAUGE]           │  │    [CONSTRUCT RADAR CHART]      │  │
│  │       Score: 27             │  │                                 │  │
│  │                             │  │                                 │  │
│  └─────────────────────────────┘  └─────────────────────────────────┘  │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────────┐│
│  │                                                                     ││
│  │  [TYPOLOGY BADGE - MODERATE USER]                                   ││
│  │                                                                     ││
│  └─────────────────────────────────────────────────────────────────────┘│
│                                                                         │
│  YOUR PERSONALIZED RECOMMENDATIONS                                      │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐                  │
│  │ Focus Area 1  │ │ Focus Area 2  │ │ Focus Area 3  │                  │
│  │ [PV: Value]   │ │ [HM: Engage]  │ │ [SI: Social]  │                  │
│  └───────────────┘ └───────────────┘ └───────────────┘                  │
│                                                                         │
│  [Download PDF]  [Share Results]  [Retake Assessment]                   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### Mobile Layout (<768px)

```
┌─────────────────────────┐
│  ☰  AIRS Enterprise     │
├─────────────────────────┤
│                         │
│  YOUR AI READINESS      │
│  ───────────────────    │
│                         │
│  ┌───────────────────┐  │
│  │   [AIRS GAUGE]    │  │
│  │    Score: 27      │  │
│  └───────────────────┘  │
│                         │
│  ┌───────────────────┐  │
│  │ [TYPOLOGY BADGE]  │  │
│  │  MODERATE USER    │  │
│  └───────────────────┘  │
│                         │
│  ┌───────────────────┐  │
│  │ [RADAR CHART]     │  │
│  │   (Scrollable)    │  │
│  └───────────────────┘  │
│                         │
│  RECOMMENDATIONS        │
│  ───────────────────    │
│                         │
│  ┌───────────────────┐  │
│  │ Focus Area 1      │  │
│  └───────────────────┘  │
│  ┌───────────────────┐  │
│  │ Focus Area 2      │  │
│  └───────────────────┘  │
│  ┌───────────────────┐  │
│  │ Focus Area 3      │  │
│  └───────────────────┘  │
│                         │
│  [Download] [Share]     │
│                         │
└─────────────────────────┘
```

---

## 5. Color Palette

### Primary Colors

| Use | Hex | Tailwind |
|-----|-----|----------|
| Primary Blue | #3b82f6 | blue-500 |
| Primary Purple | #8b5cf6 | violet-500 |
| Primary Cyan | #06b6d4 | cyan-500 |

### Typology Colors

| Typology | Hex | Tailwind | Usage |
|----------|-----|----------|-------|
| Skeptic | #ef4444 | red-500 | Badge, gauge zone |
| Moderate | #f59e0b | amber-500 | Badge, gauge zone |
| Enthusiast | #10b981 | emerald-500 | Badge, gauge zone |

### Neutral Colors

| Use | Hex | Tailwind |
|-----|-----|----------|
| Background | #0f172a | slate-900 |
| Card Background | #1e293b | slate-800 |
| Text Primary | #f8fafc | slate-50 |
| Text Secondary | #94a3b8 | slate-400 |
| Border | #334155 | slate-700 |

---

## 6. Animation Specifications

### Gauge Animation

```css
/* Score needle animation */
@keyframes gauge-fill {
  from {
    transform: rotate(-90deg); /* Starting at min */
  }
  to {
    transform: rotate(var(--target-rotation));
  }
}

.gauge-needle {
  animation: gauge-fill 1s ease-out forwards;
}
```

### Radar Chart Animation

```css
/* Radar plot area expansion */
@keyframes radar-expand {
  from {
    transform: scale(0);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

.radar-plot {
  animation: radar-expand 0.8s ease-out 0.3s forwards;
}
```

### Typology Badge Animation

```css
/* Badge slide-in */
@keyframes badge-reveal {
  from {
    transform: translateY(20px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.typology-badge {
  animation: badge-reveal 0.5s ease-out 0.5s forwards;
}
```

---

## 7. Accessibility Requirements

| Requirement | Implementation |
|-------------|----------------|
| Color Contrast | All text ≥4.5:1 against background |
| Screen Reader | ARIA labels for gauge and chart |
| Keyboard Navigation | Tab-accessible recommendations |
| Reduced Motion | Respect `prefers-reduced-motion` |
| Alt Text | Descriptive alt for all visualizations |

### ARIA Labels Example

```html
<div
  role="meter"
  aria-label="AIRS Score"
  aria-valuenow="27"
  aria-valuemin="8"
  aria-valuemax="40"
  aria-valuetext="27 out of 40, classified as Moderate User"
>
```

---

## 8. Export Formats

### PDF Report

| Section | Content |
|---------|---------|
| Header | AIRS Logo, Date, User name (optional) |
| Summary | AIRS Score, Typology, One-line description |
| Visualizations | Gauge (static), Radar chart (static) |
| Construct Breakdown | Table with all 8 scores |
| Recommendations | Top 3 focus areas with actions |
| Footer | Research citation, Disclaimer |

### Data Export (JSON)

```json
{
  "assessmentId": "uuid",
  "completedAt": "2025-12-23T10:30:00Z",
  "airsScore": 27,
  "typology": "moderate",
  "constructs": {
    "PE": 4.2,
    "EE": 4.5,
    "SI": 3.5,
    "FC": 3.2,
    "HM": 4.0,
    "PV": 4.8,
    "HB": 2.1,
    "TR": 3.8
  },
  "recommendations": [
    { "construct": "HB", "priority": 1, "action": "Build daily AI habits" },
    { "construct": "FC", "priority": 2, "action": "Explore available resources" },
    { "construct": "SI", "priority": 3, "action": "Connect with AI-using peers" }
  ]
}
```

---

*Specification complete. Ready for Phase 1 implementation.*
