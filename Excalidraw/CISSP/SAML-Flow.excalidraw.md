---

excalidraw-plugin: parsed
tags: [excalidraw]

---

# Excalidraw Data

## Text Elements
SAML 2.0 — SP-Initiated Single Sign-On Flow ^title

User Browser ^user_box_lbl

SP (Service Provider)
e.g. Workday, app ^sp_box_lbl

IdP (Identity Provider)
e.g. ADFS, Okta ^idp_box_lbl

1. User requests protected resource ^s1_lbl

2. 302 Redirect — SAMLRequest in URL ^s2_lbl

3. GET /sso?SAMLRequest=... ^s3_lbl

4. User authenticates (pwd + MFA) ^auth_lbl

5. HTML auto-submit form with signed SAML Assertion ^s5_lbl

6. Browser auto-POSTs SAMLResponse to ACS URL ^s6_lbl

7. Validates signature -> session created -> access ^s7_lbl

SP-Initiated vs IdP-Initiated

SP-Initiated (above): SP creates AuthnRequest, redirects user to IdP. SP can require specific auth context (e.g. MFA).
IdP-Initiated: User starts at IdP portal, clicks app. No AuthnRequest. SP cannot enforce auth context. CSRF risk. ^compare_lbl

3 Assertion types: Authentication | Authorization | Attribute  |  Signed XML (IdP cert in metadata)  |  HTTP-Redirect (GET) & HTTP-POST (response) ^key_lbl

%%
## Drawing
```json
{
  "type": "excalidraw",
  "version": 2,
  "source": "https://excalidraw.com",
  "elements": [
    {
      "id": "title",
      "type": "text",
      "x": 185,
      "y": 10,
      "width": 491.92,
      "height": 29.700000000000003,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1433603,
      "version": 1,
      "versionNonce": 1446327,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "SAML 2.0 — SP-Initiated Single Sign-On Flow",
      "originalText": "SAML 2.0 — SP-Initiated Single Sign-On Flow",
      "fontSize": 22,
      "fontFamily": 1,
      "textAlign": "left",
      "verticalAlign": "top",
      "containerId": null,
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "user_box",
      "type": "rectangle",
      "x": 50,
      "y": 65,
      "width": 200,
      "height": 65,
      "angle": 0,
      "strokeColor": "#2563eb",
      "backgroundColor": "#a5d8ff",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 3
      },
      "seed": 1457327,
      "version": 1,
      "versionNonce": 1469337,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "user_box_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false
    },
    {
      "id": "user_box_lbl",
      "type": "text",
      "x": 90.0,
      "y": 84.9,
      "width": 112.32000000000001,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#2563eb",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1488756,
      "version": 1,
      "versionNonce": 1501830,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "User Browser",
      "originalText": "User Browser",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "user_box",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "sp_box",
      "type": "rectangle",
      "x": 485,
      "y": 65,
      "width": 230,
      "height": 65,
      "angle": 0,
      "strokeColor": "#e8590c",
      "backgroundColor": "#ffd8a8",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 3
      },
      "seed": 1508571,
      "version": 1,
      "versionNonce": 1521190,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "sp_box_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false
    },
    {
      "id": "sp_box_lbl",
      "type": "text",
      "x": 540.0,
      "y": 86.3,
      "width": 174.72,
      "height": 43.2,
      "angle": 0,
      "strokeColor": "#e8590c",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1535552,
      "version": 1,
      "versionNonce": 1549597,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "SP (Service Provider)\ne.g. Workday, app",
      "originalText": "SP (Service Provider)\ne.g. Workday, app",
      "fontSize": 16,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "sp_box",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "idp_box",
      "type": "rectangle",
      "x": 930,
      "y": 65,
      "width": 220,
      "height": 65,
      "angle": 0,
      "strokeColor": "#8b5cf6",
      "backgroundColor": "#d0bfff",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 3
      },
      "seed": 1563051,
      "version": 1,
      "versionNonce": 1580683,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "idp_box_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false
    },
    {
      "id": "idp_box_lbl",
      "type": "text",
      "x": 980.0,
      "y": 86.3,
      "width": 191.36,
      "height": 43.2,
      "angle": 0,
      "strokeColor": "#8b5cf6",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1596875,
      "version": 1,
      "versionNonce": 1601481,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "IdP (Identity Provider)\ne.g. ADFS, Okta",
      "originalText": "IdP (Identity Provider)\ne.g. ADFS, Okta",
      "fontSize": 16,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "idp_box",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "u_life",
      "type": "arrow",
      "x": 150,
      "y": 130,
      "width": 1,
      "height": 520,
      "angle": 0,
      "strokeColor": "#cccccc",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "dashed",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1620082,
      "version": 1,
      "versionNonce": 1633367,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          0,
          0
        ],
        [
          0,
          520
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": null
    },
    {
      "id": "sp_life",
      "type": "arrow",
      "x": 600,
      "y": 130,
      "width": 1,
      "height": 520,
      "angle": 0,
      "strokeColor": "#cccccc",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "dashed",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1650215,
      "version": 1,
      "versionNonce": 1661457,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          0,
          0
        ],
        [
          0,
          520
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": null
    },
    {
      "id": "idp_life",
      "type": "arrow",
      "x": 1040,
      "y": 130,
      "width": 1,
      "height": 520,
      "angle": 0,
      "strokeColor": "#cccccc",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "dashed",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1675795,
      "version": 1,
      "versionNonce": 1684582,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          0,
          0
        ],
        [
          0,
          520
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": null
    },
    {
      "id": "s1",
      "type": "arrow",
      "x": 150,
      "y": 170,
      "width": 450,
      "height": 1,
      "angle": 0,
      "strokeColor": "#2563eb",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2.5,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1702864,
      "version": 1,
      "versionNonce": 1707325,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "s1_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          0,
          0
        ],
        [
          450,
          0
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": "arrow"
    },
    {
      "id": "s1_lbl",
      "type": "text",
      "x": 255.0,
      "y": 157.4,
      "width": 327.6,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1722350,
      "version": 1,
      "versionNonce": 1742608,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "1. User requests protected resource",
      "originalText": "1. User requests protected resource",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "s1",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "s2",
      "type": "arrow",
      "x": 150,
      "y": 228,
      "width": 450,
      "height": 1,
      "angle": 0,
      "strokeColor": "#e8590c",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2.5,
      "strokeStyle": "dashed",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1751519,
      "version": 1,
      "versionNonce": 1766058,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "s2_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          450,
          0
        ],
        [
          0,
          0
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": "arrow"
    },
    {
      "id": "s2_lbl",
      "type": "text",
      "x": 255.0,
      "y": 215.4,
      "width": 336.96000000000004,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1775649,
      "version": 1,
      "versionNonce": 1791967,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "2. 302 Redirect — SAMLRequest in URL",
      "originalText": "2. 302 Redirect — SAMLRequest in URL",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "s2",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "s3",
      "type": "arrow",
      "x": 150,
      "y": 288,
      "width": 890,
      "height": 1,
      "angle": 0,
      "strokeColor": "#2563eb",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2.5,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1807619,
      "version": 1,
      "versionNonce": 1816424,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "s3_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          0,
          0
        ],
        [
          890,
          0
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": "arrow"
    },
    {
      "id": "s3_lbl",
      "type": "text",
      "x": 475.0,
      "y": 275.4,
      "width": 252.72,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1834603,
      "version": 1,
      "versionNonce": 1840560,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "3. GET /sso?SAMLRequest=...",
      "originalText": "3. GET /sso?SAMLRequest=...",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "s3",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "auth",
      "type": "rectangle",
      "x": 870,
      "y": 313,
      "width": 270,
      "height": 45,
      "angle": 0,
      "strokeColor": "#8b5cf6",
      "backgroundColor": "#e5dbff",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 3
      },
      "seed": 1858159,
      "version": 1,
      "versionNonce": 1875382,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "auth_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false
    },
    {
      "id": "auth_lbl",
      "type": "text",
      "x": 945.0,
      "y": 325.0,
      "width": 257.40000000000003,
      "height": 20.25,
      "angle": 0,
      "strokeColor": "#8b5cf6",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1883445,
      "version": 1,
      "versionNonce": 1902172,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "4. User authenticates (pwd + MFA)",
      "originalText": "4. User authenticates (pwd + MFA)",
      "fontSize": 15,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "auth",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "s5",
      "type": "arrow",
      "x": 150,
      "y": 388,
      "width": 890,
      "height": 1,
      "angle": 0,
      "strokeColor": "#8b5cf6",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2.5,
      "strokeStyle": "dashed",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1908935,
      "version": 1,
      "versionNonce": 1925418,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "s5_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          890,
          0
        ],
        [
          0,
          0
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": "arrow"
    },
    {
      "id": "s5_lbl",
      "type": "text",
      "x": 475.0,
      "y": 375.4,
      "width": 477.36,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1942183,
      "version": 1,
      "versionNonce": 1957180,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "5. HTML auto-submit form with signed SAML Assertion",
      "originalText": "5. HTML auto-submit form with signed SAML Assertion",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "s5",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "s6",
      "type": "arrow",
      "x": 150,
      "y": 448,
      "width": 450,
      "height": 1,
      "angle": 0,
      "strokeColor": "#2563eb",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2.5,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 1963798,
      "version": 1,
      "versionNonce": 1976381,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "s6_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          0,
          0
        ],
        [
          450,
          0
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": "arrow"
    },
    {
      "id": "s6_lbl",
      "type": "text",
      "x": 255.0,
      "y": 435.4,
      "width": 421.2,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 1993340,
      "version": 1,
      "versionNonce": 2003197,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "6. Browser auto-POSTs SAMLResponse to ACS URL",
      "originalText": "6. Browser auto-POSTs SAMLResponse to ACS URL",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "s6",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "s7",
      "type": "arrow",
      "x": 150,
      "y": 508,
      "width": 450,
      "height": 1,
      "angle": 0,
      "strokeColor": "#22c55e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2.5,
      "strokeStyle": "dashed",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": {
        "type": 2
      },
      "seed": 2022725,
      "version": 1,
      "versionNonce": 2035914,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "s7_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "points": [
        [
          450,
          0
        ],
        [
          0,
          0
        ]
      ],
      "lastCommittedPoint": null,
      "startBinding": null,
      "endBinding": null,
      "startArrowhead": null,
      "endArrowhead": "arrow"
    },
    {
      "id": "s7_lbl",
      "type": "text",
      "x": 255.0,
      "y": 495.4,
      "width": 477.36,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 2040571,
      "version": 1,
      "versionNonce": 2063712,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "7. Validates signature -> session created -> access",
      "originalText": "7. Validates signature -> session created -> access",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "s7",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "compare",
      "type": "rectangle",
      "x": 10,
      "y": 685,
      "width": 1180,
      "height": 90,
      "angle": 0,
      "strokeColor": "#adb5bd",
      "backgroundColor": "#f8f9fa",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 2072546,
      "version": 1,
      "versionNonce": 2088578,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "compare_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false
    },
    {
      "id": "compare_lbl",
      "type": "text",
      "x": 540.0,
      "y": 719.5,
      "width": 920.4,
      "height": 81.0,
      "angle": 0,
      "strokeColor": "#adb5bd",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 2094229,
      "version": 1,
      "versionNonce": 2109079,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "SP-Initiated vs IdP-Initiated\n\nSP-Initiated (above): SP creates AuthnRequest, redirects user to IdP. SP can require specific auth context (e.g. MFA).\nIdP-Initiated: User starts at IdP portal, clicks app. No AuthnRequest. SP cannot enforce auth context. CSRF risk.",
      "originalText": "SP-Initiated vs IdP-Initiated\n\nSP-Initiated (above): SP creates AuthnRequest, redirects user to IdP. SP can require specific auth context (e.g. MFA).\nIdP-Initiated: User starts at IdP portal, clicks app. No AuthnRequest. SP cannot enforce auth context. CSRF risk.",
      "fontSize": 15,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "compare",
      "lineHeight": 1.25,
      "autoResize": true
    },
    {
      "id": "key",
      "type": "rectangle",
      "x": 10,
      "y": 785,
      "width": 1180,
      "height": 55,
      "angle": 0,
      "strokeColor": "#4a9eed",
      "backgroundColor": "#dbe4ff",
      "fillStyle": "solid",
      "strokeWidth": 1,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 2126531,
      "version": 1,
      "versionNonce": 2138959,
      "isDeleted": false,
      "boundElements": [
        {
          "type": "text",
          "id": "key_lbl"
        }
      ],
      "updated": 1700000000000,
      "link": null,
      "locked": false
    },
    {
      "id": "key_lbl",
      "type": "text",
      "x": 540.0,
      "y": 799.9,
      "width": 1366.56,
      "height": 24.3,
      "angle": 0,
      "strokeColor": "#4a9eed",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "roundness": null,
      "seed": 2151181,
      "version": 1,
      "versionNonce": 2161544,
      "isDeleted": false,
      "boundElements": [],
      "updated": 1700000000000,
      "link": null,
      "locked": false,
      "text": "3 Assertion types: Authentication | Authorization | Attribute  |  Signed XML (IdP cert in metadata)  |  HTTP-Redirect (GET) & HTTP-POST (response)",
      "originalText": "3 Assertion types: Authentication | Authorization | Attribute  |  Signed XML (IdP cert in metadata)  |  HTTP-Redirect (GET) & HTTP-POST (response)",
      "fontSize": 18,
      "fontFamily": 1,
      "textAlign": "center",
      "verticalAlign": "middle",
      "containerId": "key",
      "lineHeight": 1.25,
      "autoResize": true
    }
  ],
  "appState": {
    "gridSize": null,
    "viewBackgroundColor": "#ffffff"
  },
  "files": {}
}
```
%%