<xsl:template name="section-reportSummary" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">


    <!--
  ============== HEADER ==============
-->
    <fo:block xsl:use-attribute-sets="class-h1">
        <fo:marker marker-class-name="footer">
            <xsl:call-template name="element-image-base64">
                <xsl:with-param name="width" select="'7.5in'" />
                <xsl:with-param name="height" select="'0.16in'" />
                <xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAACWAAAAAyCAYAAADYk+BBAAAgAElEQVR4nO29e5Ar133n951pTAON5+A1wAxm7rzug5ekyZAUY8emI3KlhJETO7YkJja5RWddkVS2dv3Y2BUlZXqTyH/slm1p5SpbJWWjTbQl2alKnFppa2Vu2ZG8pSirkkiGFGmS9965d+7FHQxmgAEGg0cDPeiZ/DHTuN2nu4EG0AC6Mb9PFat4zzS6T/c53/M7fc6vf7+Z3Q99+BQ2cCL47TgNQRAAhN/5bUT/w5/WlN26cw+Vo+qEakQQhFUur19CJBzSlJF+CcIdkH4Jwr2QfgnCvZB+CcK9kH4Jwr2QfgnCvZB+CcK9kH4Jwj20ZXmg383aXA+CIGyg/pV/DlmSNGUrmTRmZmcmVCOCIKySzeVxcqr1bSb9EoQ7IP0ShHsh/RKEeyH9EoR7If0ShHsh/RKEeyH9EoR7If0SxPQzY1cELIIg7OXk538eS3//05qynd093N/dm1CNCIKwSmYxheXFlKaM9EsQ7oD0SxDuhfRLEO6F9EsQ7oX0SxDuhfRLEO6F9EsQ7oX0SxDTDUXAIgiHMvOv/hUad+5oyhbTC/B5vROqEUEQVtnN76PZamnKSL8E4Q5IvwThXki/BOFeSL8E4V5IvwThXki/BOFeSL8E4V5IvwQx3ZADFkE4lJl2G6XPfV5TNjszg7WVzIRqRBCEVU5OT7Gd3dGUkX4Jwh2QfgnCvZB+CcK9kH4Jwr2QfgnCvZB+CcK9kH4Jwr2QfgliuuF+e2Pjf5h0JQiCMGa2WIQYTyBw9UqnzOfl0Wy2IDabE6wZQRC9aLUkCD4v/IKvU0b6JQh3QPolCPdC+iUI90L6JQj3QvolCPdC+iUI90L6JQj3QvoliOmFImARhMORvvIVtGt1Tdml5UVwHMmXIJzOvfu7kOUTTRnplyDcAemXINwL6Zcg3AvplyDcC+mXINwL6Zcg3AvplyDcC+mXIKYTioBFEA5nttVC9fAQ4Z/8yU4Zx3GYmZ1B5ag2wZoRBNEL+eQEp6eniIRDnTLSL0G4A9IvQbgX0i9BuBfSL0G4F9IvQbgX0i9BuBfSL0G4F9IvQUwn5EJJEC6A+zf/BtV339OUpZMJTWhKgiCcSb5QREPUhowl/RKEOyD9EoR7If0ShHsh/RKEeyH9EoR7If0ShHsh/RKEeyH9EsT0QQ5YBOEGTk5Q+af/FDg97RTNzMxgbSUzwUoRBGGF09NTbGd3NGWkX4JwB6RfgnAvpF+CcC+kX4JwL6RfgnAvpF+CcC+kX4JwL6Rfgpg+KAUhQbiE2XIZjWAQgYevd8q8PA9JknTe0QRBOAtJOoaX5xHwC50y0i9BuAPSL0G4F9IvQbgX0i9BuBfSL0G4F9IvQbgX0i9BuBfSL0FMF55JV4AgCOu0/8W/wPFzz2EuFu2UrWQWUa4cod2WJ1gzgiB6kd3ZRTQShsfDdcpIvwThDki/BOFeSL8E4V7crF+vl4dfEOD18pryRkNEoyGiLTu7/gQxLJPUr4fj4FdtXvXiqFobYW2IURLwC+C4B32sJUlotaS+zuH18vDyD8ZqWZZRb4i21bEbAb+AUCjY+XerJaEhin3fg9242f4OSljVDgAurK22Q1NqjMZjGnNHy7j1y2rHjHFpiq3PIP2t2zlYmzGsRoatWzcu6jg2DHb0n2Fwu/1Vxnz1uC/LMhoNcWxzK7Yuatj2nFYbZbctJwZjZvdDHz7tfZh74DY34XnkYXCLi5ry9o0baL/1I5wcHEyoZgRhD+1nn8Py7/73mrL94gHu3Nsx+YUz8XCcxpvbCpUpMH6DYvS8RvE8xnWdi8pCIo71S9rQsW7UbzciXV4E611e/HzMC6ya9hgXQAnCDLfpl9ViN/1dVAJ+AR7mhbSpeiElmzg9uE2/biHgF3Q6Umz2KOx2L80S04nb9BsOBZFaSCIUDHQ97qBURn6/YHkh1MNxSCRiyO8V7KhmT6LzEUiSRHPwMTDuth0nk9JvOBTE5Y21vn4jSRKKpTKKxRLNmV3Elc11zXiby+/1raV0KomldKrz72qtjptbd2yroxEejsP62iVDWyHLMt58+92RXt8KbrO/w/Lk449q/n3r9vZUbML2ix2aUmM0Hr/+5tsDn4+wxjj1y2qnG4qtHeWch63PIP2t2zlYmzGsRoatWy9oftMfdvSfYXGj/bXyDixJEvYKRRSKpbHVqZf9cbON6va+brctJwZjaiJg8c89C/8v/AL4a9e6Hid+97tofP3PIG9tjalmBGEvnr/5Dir/6c8g8sS/1ylbSMRROCijVm9MsGb9EfALuLqx2vfvZFlGuXKE3f3ihdpwMXpeP3jzHdde56KyXzxAMh5FMODvlLlRv93opuud/D5yJpO95cUUopGw4d+qtTre29q2o3q24+E4LCRipvdFTA9u0y+rxRu377rKeWgc2lpZTGleSNkximxifzh5PHSbfp2M0s7pZFzzRR1LSzpGsVTGfp8LvfH5CJomi0i9NEtMJ27SbzIRw0pmydKx8VgU85Ewbt3e7unklE4lkUom0BCbI1849Xp5XFrOIBQM4Nbt7ZFeixhv204CN+mX53kspVNIxKK4czdLzofESDFzvgLO1j+cgJv0SxCEFqfqV7G1Xp7H3axznUmmCeWZRyMR3Ny6Q05YLsCp+jXCw3G4tJLBvMmejhqe57GSWUIiFqO+OAT0vu4eZiddATsQXnoR85/5TE/nKwAQnnkGsT/6Q8w99eQYakYQI+D0FNUv/DFOGQO1tpLBzMzMhCo1PjiOQyIWxcNXNvqOoEUQTmA7u4PTU23wyYuiX7/gM/1buEeUACeylErisetXXFl3YjAusn7HCWnLfbihzUi/wxOfj+Cx61eQSS90db4CAC8/h0x6AQ9f3bQ0Z/d5eTy0uYaN1WVNlCuCANyh33AoaNn5SoHjOFzeWNOlKVQI+AVcv3oZS+lUT83ZQTqVxCMPXe0ZvYsYnnG37SRxg37V8PzZpgZBjAoPx+nGWVmWUa3VIYpNNETnOP+5Tb8EQTzAyfqNx6JIp5KTrsaFQhB8yCylJ10NwiJO1q+Ch+NwZXPdkvOVGkHw4crmOq37DAC9r7sL10fA4p97FqGXX+7rNzOCgPlXXkHpv/ltioRFuBLP/Sz2/+x/R+rvvtgpC/gFLCRi2CtcjDSbHMfh2sYq3nr3JnlLE66i3hCxXywhlYx3yi6Kfs025tm81E4n4BewtrzU1aGMmE4usn7HAWnLfbipzUi/w7GQiGE1s9j377z8HB6+soG7O7vYNwk1v5RKIpNeGLaKxBTjBv1mFvUbGgelMhqi2Ekz6PcLSMSi4FVptzmOQ3ohaRgFIBQKQhjj+KpOp0KMlnG37SRxin5z+T1d2ZkjjL4tBMGHdCo5lVHJiMnjN3BMtxINcRI4Rb/E+DisVFCtPYic3RiyX7YkyXD8JUbPpPRr1N7RSERna1PJhCvT4jUaouYeh9XIsJjpy8vzmI+ENevt8Vi0rxToxORwg/29tJLR6VqWZRyUyp0UvhzHIRwK6vqi4hBIkfD6w+r7ut22nBgM1ztgBV96SVcmfve7aN++DTmXAwB4rl6F8MEPgos/GKxmBAH+F38J1c/+/tjqShB2Iv/5n6H1H/9H8C48+FpgZSmN0mEFx8ftCdZscHby+6Z/8/JziDKGmuM4LKaSyOby46jehaAlSV3bgbCHbC6P2HwEc3MPzLDb9WsFjuMQ8Au6hcVIKDihGg1GJBR0hbMBMRouqn7HAWnLfbitzUi/gxHwC1g2cJBqSccoV446i2vKsYlYFF5+TnPscnoB9YZouLlIzleEFZysX6+X1y0+37mbRfmwoik7qtaQ3yvg+tXLmuPjsSgtPhNTjRP0282ZKhwKYn11RbPeFAoGyQGLGBtOdL5ScIJ+ifFRMPlgYlBaLYnG0gkyCf0atXd+r6BL1c1xHPx+QfMu6QaOqjVH1bmbvnZyeTxy/apmfhMOBVFo2atzYjQ42f5G5yO6yFcHpTJ2cnmdU2X5sIL8fgEbq5d078DkEDga7LblxGC42gGL29yEZ2VFU1b5kz9B6xvf1JRJ3/4OGl/6MmL/7H/WHC888wyqY6kpQdjPbLOJwh//MZZ//7OdMo7jcCmzhK3texOs2eDkeryQZXN7uLa5ptnoc3KqGzfSbEk924EYHlmWcW8nh821S50yt+vXjJZ0rNmENXLAYjfv2d8QhJO4SPoliGmD9DsYK4v6FFk7+X3DOWOlWkNur6CLasVxHFYWU3hva3vU1SWmFCfr18vrUwiyzldq8vsFrK9q17LCoWBnM8fr5eHled15PedfEANnz8Nswz4cCuoirLRakiYaF3u8EepzNBqiaYQC9nqNhtj1eM/5hpsa5d49HIdoNNIZc6rVmu4+PRyHUCjYSd3Yakldn7cddQb0UXtbktR5nl4vj3Ao2Pl7oyEabs4N07YBvwA/UwdZltEwcW51Ek7WL3DW//YKRc1X5b1SewzSh8z6vrrfy7JsuGlid/uz9W+1JFSrtZ6RSOzQgRHsbxX6OccosVP/RhGw1ONwt/s1ek5G46SdOF2/42RU/d/Iril67GYzrdSLvc6w5+p3HLNyTZZBxlf2HtxqL+3GSfotFEsIBYMapw3WAYudkxr1FSvHGBHwCwid/3aQuaOCMpYrmOlNwag/j8uutc+jES0kE52ybhkovF4e0flI59/91nXYex3k92btEZ2PwOvlTdta+TswuB1l62v3OOMk/bKkF7QpRKu1etcPilotCffu7+DalU1NeTIew/0ewTUmMffpxrA2CtCOR0DvvtPv+7rVeYGaQZ9zLzuvfl6yLOOoWrPkdDcNttzdDliXVnRlrPOVmvo3voHIpz+tKeOfexbSt7+jKZt76knMhB9MBOR7WcNUhbPxODyP/ZimTH2ubn+fjcfh/U+ex0zwTDjHP/whjl97XXf+uZ/6SXCLZ6ke5N3drvfXrd5zTz2JuQ98AABwWquh9Zev4uTgQPd75RgAaP3VX1tO0chtboL/iR/v3I9C+8YN3fNl79HoGamfz2mtBunffV/T3qdHR7rnpYZ/7lltPd76ke5+pwHP97+P8vf+X0R/8j/olCVi8ygclByxQGE3bVlGfr+IjdXlTpmVqAuRUBABlRFQvr43Moo+ZtLW7rKwPejx4VBQk+O4MuSEwc46e84jFKmpMH2p1zHq590+N6pNi57sAb+giYZUOqx0fhvwC5rn1pIky+d1IsXSIZLxmGYCNY36rdZq8MainX8HDDTrF7T9if2NVVitt1oSKhYXkY36lro/ls5f1s42TLTOYRzHdY7rpj87+zd7r8r91kVxInpjxzblObhlQtwv06Lfbu3Mtmm9IersgRGKjWD7pxXbO6i27NDDIHSzhx6OQywa6Tw/I1vvOb8/9UL7QZ+LgP3McRTsaPdh22ySTIt+x0V8PqLbhDZzvlKj/F3thBUKBhAJBTt9yiwCJtunrSxksTat3/n1IFoyGwPU+m/LsmnqRaJ/3KTfbunLyocVzdivLCQqROcjhukFBMGHyxtrAM4WuW9u3dFdM5VMdN1YMfoyWTkni7oOt25v655xMhFDKpnQpFRUkGUZe4WiYWoZv1/QXfP1N982rn86hcPKEe5ld9CWZSQTMSyl9U6hmcUU7tzN9tT9oHUGgKXFtGY8zOX3UCyWkFlKI27w7iJJkq5Og7RtdD6CzGLKsM7qa+3s7g28mTgOnK5fq6k5hulDRn3/rbffxZXNdU1EgEQshndv3AJgb/t7OA7pVBLxWNR0nDgolbtGI7BDB2oCfkF3TqNzTLp/j1L/gHYcfv3Nt3V/D4eCyCymjVOXplOQJAl7heLIIh44Xb/jwu7+D5jbblmWce9+DrIsG9rMXvUymoOY2d9+ztXvOGblmgrDjK/A9NhLu3GSfhuiqIuao8ZKX7HanxQ8HIdLKxnddTOLKdy7n+v7GbBjuZneuvVHSZIGuvYgWHmX9nBc13Gsl2aGvddu2u91faP28HCcxuksHAp2nIPCoSAuLS9pr6V637BCr3euaq2O3G7elvUwJ+lXwSj6c263d4aiekPEQakMvyCgJZ19HFTtcg+TnvuwDGujAJP+p8JML/2+r1udFyh1GuY5m9n5buPCfqFo6ng3Tbbc1Q5YRvg/9Uk0vvRlw7+1vvFN1FTOTKfVKtpv/Uh3XOCXfxn8tWudf9f+4i/QMHBE8jz2Y5j/zGc0ZfsqZyOzv/s/9UkEPvIRzKg3nD/6UbTeeAPVP/hDnBwcQHjpRQRfeEF7DAD5F38RR3/0R4bOR0b1Pp6P6MoBIPjCCzj6ylfQ+sY3MRuPI/yPfk9/zEc/isarr6L2uc/rrqUw99SThufX1PkTn0Dtz//c0HnM6BkV3/oR5v/JP9ZGN3v5Zc0xp6KIws//gmmd1OfsdqzrOT1F40/+BPNPfwAzcw82wNZWMvjRuzdweno6wcqNhn48iRcSMaSTCcNIOrIsI184wD5jFMOhIFYzi51/t6RjvPXuDdNrLC4kkFBNToulMu4YTK4ioSCWF1OGDmOZ9AJa0jHyheJAGzR21jngF3B1Y1Vz/A/efEfzb7Nj4ufG0eh55wsHXVNFBvwC1paXdM8nk17o/HZlMaWZOFjZ/HM629kd/Nj1q5iZmemUTZt+W9Kx5t8hxlH3bBP/QZ+RZVn3m254zlORJmPzpi8+xVIZu/tFU0cMo77VlmWNrjLpBezk9w3TJPkFX0cT1VpdF93Dzv69lEoinYx33VgrlsrI5vZMx0s76+Pz8roxRU21VsfuftGS447bmAb9GrXzfrGElaWUYZu2pGNsmSwgezjO9HdqjPpnbD4ykLbs0MMwmNlDo3pl0gsoV46wnc2hLctYSMSwnF4w3EA2e8ZqBpnjKNjR7oO2mVOYBv2Oi3BIuyHako4tz79yewVdOsLYfLhjE1j9KKj71o3bd7vakIBf0PVp5RzVWh3Z3b2uehpGS0ZjwBtvv6eL2JuMRfHODWsfNhG9caJ+j6o1yLKsGdOX0imEgkEcVioolyu6PmR3Op7VlYzhpglLPBaFXxBwc+vOULax1/U4jsNSOoVoJGLpWt3Op2yYSZKk2UxRw/M8Lm+s4b2bW6aOI3bX2cNxug3nfuvUCzZdjxk8z2N9dQUeD+folBNO1K+C4hTZDbv7EABcWsno+lBLOusvdrZ/4HxzpNu8GTgbI+YjYdy7n7O0qTGMDqzWyYn9exz6V7AyvvM8j5XMEkLBYMdh1W6crN9JMWw/6Na2HMdhfXUF+4WirXUeBd3GMasMO75Om720G6fo1yhq7Kgx06iiz/dvbtn+4Viv/qhc2+gDB7th1+FlRjtWxrFumhn2XntpX7m+2omqG6FgULc2oIxHAQNHEYX5SNhS/0ynkqbO1A/qELBtDgA4R78K6ihpwNk7mlUNWWlDwDlzH6v1sfIOYMVOKXrJ7uTGYqNG9Zx73avyTs86YU2bLZ+ddAWGQfr2d3AqaoUd/OhHMf/HX4Dw0ouYjcd1v2l86ctofOnLaH3jm5C+/Z2xR0UKvfK7CH70ozrHKgDwPvEEQr/z2wj+w99C6OWXDY/h4nHMv/IKuM1N3d9Y5tbXMf/KK4bOUTOCgMinPw3vz/0s4v/LPzN1oPI//zyC//C3jM//1JOm52frHPn0pyG89GLPOgNA6Hd+W5dasvXGG5BVbTUjCPD+3M8a/t77wQ9q/t187TVL13Ur3N4e8v/r/6YpE3xeLKaSJr9wN2y4RTNHjfWVJaxmFk3TmHEch0x6Adc21zRRIPaLJc1E1MvPIc5MKhQ8HKfbqNw/KBvW5erGatdoXV5+DquZRVxeW9HUxwqjqHO/LCRi2FhdNn3e6WQcK0tpw78F/AKudXk+6WQcD22uDV1HJyI2W9hlNl+mTb/1hqjrnz7V4rYudHStbvncAb+Ax65f6emAkYhF8fCVDVNdsPgFn8b5ahjs7N/rK0vIGDhssCRiUd3YNor6BPwCHr6y0dXhJhQM4OrGKhYSMUvndBPTqF+O43Btc820Tb38HK5trGo0DJzZlm6/U9Otf/aDHXoYBd3qFY2EsbayhJWlNFYzi4bHmD1j9hqDzHHMGLTd3cw06ndURJkvhYul/uaN7PHs+YbBL/hwbWPVNGpGKBjAtY1VUx3YrSUAWFvROzj3uwFFdMep+t0z2CANBQNYySzhsUev4/rVy1heSiM6H7HdJkXnI7qFU0mSUK3VUTWYWwuCD4kh5mZKBB01siyjWqtDYvq7IPiwrkqbYYZyPlFsGtZ5PhLuLNQq12I3kDiO06XDGGWdF5KJzmaV2bPuVqdeeL28boNHkiTk8nvI5fewXyjqnsFKZsmSI9GkcKp+PRyHFOPcx7bnKPoQAMNIIA1RtLX9PRxn6OikjBOi2NSUK44fbJRHI4bRwaXljK5OyjnYZwqg54bnOBm1/hWM+p36mmwfmI+EcWklM9Q1zXCqfifJMP3ArG1ZO2jmeOwkzMYxqww7vk6jvbQbJ+g34Bd0fcUO55ReKBoVxabO3gHQpQUflnAoqHMgUOwt2w8vLfd2NBiUgF/A6kpG967MOkEZOVAaaW8ls6SbFwx7r/1oPx6LImnh/cVobUCJsmTU1up+YeaEpmA01hxWjgzHGY7jcGnZHnvsBP2qYd9lGwa6GgYnzX3M6tPvO0B0PmLoWGQ0DwfO5ryjtlGjfM7KvSrjgdG8fiGZ0NzjNNpy10fAqn/rWwh+9KOaMv7aNfDXriH08stoZ7OQ/vZvcXzrFo7/n+9NPA2d8MwzAIB2NouTRkPnvOR94onO/5+KIo7v3cPcpUsaZ6wZQYD/xV9C9bO/3/VayrmU83CJBDjGKU2dkrGdzQKAzvnJ//zzEP/lN3TpCEO/+qs6JzHp/fcBwPBawRdegPi1r3ets7reao7v3IG8vw//8893yvjHHzeMquVVpVEEAOnNN3te0/X8xf+F5s/8DHyqQTyTXkCxVIbURyQZJ6OkBUkntf2qXDnSHbuUSuo2EWVZRkNsgmfS5fgFHy6vrWgiNBRKh5rrhEMBw5RAsajWmaMhNnXe3kZ1AR4s5vkFn2bBSdmUurWd1f2mG3bWeRAUZ5WWdAxJknTPGThz7CgclDRRiDwch2sbq4ahttXt1S0cvdvZye8jEYuCVz2vadPvUa2u2XANh4Jots6809mUhFYn7WZ9R+mDHMdpNkA5jsPG6jKaFr7KMNocZid4w9RxkP4dn4/oxhLlXgH9C6Zf8GEhEdNEKbGzPmbnaohNyLKsO8dqZrGTEnKamDb9qu2IYqfYtuQ4DosLCdzJ5jpli6mkzuGgWCp3nKTDwYDmPH7Bh5WllOYc/WCHHkaFUi8zLajHF0V77FzA6BkrDDvHMWLQdnc706bfUeDhON043++8kT2e47hOar5hUeupW9810v8otMTWScHuBUnCmfrN7xUMv7hWEASfZlH/sHKEoknqiPxeAfm9gu4La6O0gwCQiGs3I9gUAx6Ow0NXNzVh/NVfeCupW558/FHNeYy+VDdaGD0olTVfM0fnI7i0vNQZP0LBAJKJWNevU2VZxp272c71wqGg4Rfq6hSKRl/sGz3/UdUZONu0uX33XmcD0Siijzrdej9tG52PaM4jis1OWjr1+di2TS8kLX9dPgkmpV/2wx/grG94ed4wJV+1VtMcN6o+9OB6dXg4DoLgQ/mwYmv7Z5bSuvtjxwmjlCjrqyt4u0t0dXXd+tGBcj21diVJws3b25rNeFYnHMfB6+XHsmFvhUH1bzS+GaXQMup37DWVtJJqJ535SLivvtcPTrS/k2aQ/m/k9CnLMm7d3u7Mnc3SpjkZdhyzgh3j67TaS7sZl35Ze8udp21nba0sy13Tj9mJek7LjsE8z9s6ZrLzcnV/Zufkdlybnb9346BU1thQ1imOHYeWl9Ia+5JaSOL29r3Ov4e5V6NxkNU+G51nKZ0yjCxshCg2wXFn8WfqDRHJREyX0kwdZcjs3UMNG/mJTaNWPqzg2pUHgVNCwYBt8xYn2V+BsWn9ONz2wmlzH7veATKL+ntSR8pi5w4cxyEZj3X6Vz/v64Pel93PmX3XMIq25ReEzvWm0Za73gGr8aUvg3/kEdMoTJ6VlTOHouefBz79abTeeAPiq69CUqUKHCenoojKF77QuT7/3LO6FHwAIH73u6j/6RdxcnCA2Xhcl5KPv37d0vXU5wGA+T/+gu5ZsXUSXnoRISblH/8TPw5R5YDFP/espj7ywQEOX/k9jZOW/1Of1DjHzQgCuM1NnSOXGdL772PW74dnZQWtv/przM5HNA5YvqeeQpX5zdxTT2ocv05F0dBJa9qYOZZQ/NznsfxHf9Apm52dxdpKBjccmvrFiKcff6Sv42VZRuFAO9j7vLwuJU6xVNZsGMbnI1hdXtQYxYVErJP+r3BQ0mxGJmJRw/RFScZgFJgv/I3q0hCb2Lqb7TghKenT1NeLRsKa+ljBrjoPA5uibH1lSbexFRAEjQPWQiKmWwhkz7OQiNkWjciJnJycYDu7g6uqqENu1G83GmJTsyGp3vBhF6LqDdHSl7YrS6mefScSCmJ1eUmzibq5utI1RacaxaHDL/hQrhwht1dAbq+ApVRSo22zNFt29u9kXKsl9jwejsPDVzc198o6QdpZH/b5y7KM92/f1SwWrq0sadp9dXnJ8rN3C9OoX9ZOKVHTui0gJ2Pzmn/fvntf4wRspJtELNpJDdqvtuzQw6iQZRlbd+93nA0joaBhmjV1akQlgphfs4Gs3yS0Y45jRr/t3m+bOZFp1K/dGNnjfh1pjY4P+AVUqrVOmmv2HaBX2kE1bN/1eXlc3VjTaD4cDGjGiFFqSaFaq3ecwUsWN6AI6zhVv3e27+kWKc2Yj4QxHwnjsHI0dMqEvf0CqrUaPBwHnud16Q3bsoxiqaxZZGU3IKzCbjxUa3Xdgmf5sKJb1A0Fg10XavcKRc3i8VG11vmwR0GW5eLdQREAACAASURBVI7zlXJf5UpF48RhdF+jqrMsy7oUE/WGiINSWdMHen1NbxWen0M4FNQ8p7Ys4979XGdzR5Zl29Po2M2k9NtrU02NJEkoqtp+VH0I0G92hkNBw426Qdvf6+V1mx3shghwprk7d7OajUMrG8OD6qAlScju5M5tpYDyYUV33/m9gm5zyMs7wwFrHPpnoyZJkqS7ZluWcT+XB8/zmk30VDIxEgcsp9rfSTFoP4hGI7q1mTtMyve2LONedgd+wTewzR4XVscxI0Yxvk6LvbSbcenXqr3dKxRHmjJMYd9gjrlfKGo0asVeW8HDcTqHJnV/ZufkbArzUSKKTeww6b5Y/eXyexpd3M/lMR8Jd8Yg9b0Ne68JZo3aSPt3szvgeb7zgQXHcUgkYj1TuavnOcqaBruOuV8oatrcqF/0IhQMaj4uqzdEZHdyaLfls4+7GqJtffyi2F+nzX3ssFHR+YjOjhvNHfYKRVve160w6uds9K6xk8vr3km6Ra+aBlvuegcsADj6H/8n+H/5ZY1zjhneJ56A94kn0Hr+eVT/4A/HHhGr/q1vaZy/pG9/B/InPqFzGlI7TZ0cHKD5gx8gqHJ4YqNLGcGeBwBa3/++zgGLrZP4ta8j+MIL2qhbbK7ge1lUv/pVzASDmFtfR/N739M5VjW+9GVddDLu0kpPB6xTUcThZz+L49deB3Dm7CVvbUHGWZQuxfFrRhDAP/espu5zTPSraU8/qMbz5v+H0l//34h96O90yqKqRd1pQ9nsbzIvdDEDo8hGazg4N4rqjZdwMNDZUGm2zkIjqr+ejUUjmg0Xn5fXRfsolbWbK4sL2glbSzrG+1vbOkOWzeXh5ec0jgrpZKIvByy76jwo7OY3AGRzezoHLNaoslECFCcXNfvFEjznKWCmlXLlCIeVI81kZpr0y06Ewuf91MNEqQLONmp7OWD5vLyubxn1wUq1hq27WTx8ZaNT5uXnLG2gqjdiPedf2vaLnf17d7+Io/PNXC8/pzuP8mKrPg+bu97O+rDn2rp7X7dYuJ3NIRwMdF6ovfwcAn7B0RPjQZgm/cqyrLNT9Yaoi7LI6pZdMAqHAqhUa5rzKH1Naf/6EAsRduhhVOQLBxrHkUq1hpZ0rHEGkWVZ4yR9toF8pHmuRg5jdsxxjBi03aeBadLvRYXtu82WpNM/GxFnVFoC9A7JkVBQ975C2IMT9assUhYOSkjGY5oNCzPmI2FwHGcY2coqR9Va1y9fA35Bt+kwKKyDsDpKkJryYUWzgNwrgodRBISWdKx5fg2xqZs7NCzMK0dVZ6P6AGftYUfKKKMUi5c31iBJEg4rR6g3RDRE8azt2a8THY4T9augRGNTt+2o+hBw9hW9+v1I0bJd7c9uHEmSZLpxqTiOqDdHem1KD6qDVktCoWV+Xg/HIWQQtcwpjFr/gL7/dHNW2NnNa47neX5k795O1u+4GbQfsO+motg0tONtWcZh5cjxaQjNxjEr2DG+TrO9tBun6FcUmz2daOzCqD+yGrVrvcjPrGcbpSUtFkuoVmtjWxuVZRl7hSKKxZJuvGIjGRk9K3YMUhwihr1XVvvFA+M5QfGgpHmfDwWDXfuOLMuavyvXZt+FrPQLo3OrEQQfHnv0Og4rR2iIIsqHlZE4Pys4Rb+jxGlzHztsFLunVK3VDe9pnGPDqJ+z0Tt6+zxto1nE8Gm05VPhgHVycIDa5z4P8V9+A8J//nPwfuADPR2UvE88gZl/9Hs4/PXfGFMtzzj+4Q91ZXKxqKnv8b17Osew9o3+I0ZI772nO4+c06cNMTr38b17plHFAEDe2tJExGKZjccx91M/2UdtHyD+23/bcb4CoHGwYh3R+Cee0Pzd9/TTmnM1//W/HqgObqXxlX+uccACgEuZxakxwMDZQFyuHHWiZrCEmQH8yGDyBwClw4pmQ4V1JihVjjTGIBmLajZckkyI1WKprDNS7DnzXQzZ/d09JkJQ/44KdtR5UIzq2cuoAvrN3MKBcUSu/WJpqh2wAODezq5u8jMt+mWjWPgFHzwch0iIncQa65WF3ThtScemqcXqDRHFUlnjsGVlAzWb2+v8f1uW0R5g8mtn/65Ua12jgZxtrHV3jrCrPpFQUBf9yqhuilOJ+tlHQsGpc8ACpke/3RaQ2RTAalgHo0QsikQsinLlqJPqtlKt2ZYC0A49jAqjekmSpHk+Rs/Zii7smuOwDNru08K06PciYrZw1UtPo9IScJYWXH39aUu96zScqt9WS8L9XB73c3l4vTzCoSD8goBQMGDokNVvqrJueDgOfr9w9t/5Ne38sp61r16eRzqVNDlaS7cUHFbsoNmCdy9GVedB62OVcvlsIZ9tP57nNZtDothEtVZD4aDkiMhAVnGiftUpLtWMqg8B5o4KdrU/u+HY6537qFpjHLC6p6e3SweB83HLy/MIBYO2RY4bFaPWf8Av6Nq+m1NLqyVBFJvalKwjfPd2on4nwaD9gHV66HYeO536RsUg6Y8U7Bhfp91e2s0k9as4A43L+Qowd7RRY5fNYZ2SjFKzDbrGbIZi1738nO49Q5IkvHdjy3T/h7XxrNM2oB+v/H7B0AGr33tltW+WjpIt77XW1xCbhuVsG1vpFyxmY40S2XgpnTqLoloqGzq82YET7a/HpndNJ8597LBRVp247B4bzBjHcx5kXjCNtnwqHLAU5K0t1D73edQAcJub4H/ix+HZ2AB//bqhQxZ/7RqEl16E+LWvj62OasciM6R33rHnWnesfUFpRzrGuaeehOehh8ClUuAffliTnrBfpDfeMP1b66/+WhNVy/uBD0CRMre5qUuLaOV5TxOzP/3TurIDG1PMjRr1QpDRIk9LOsbfdpk0AkZGcQ5LFo2iz8t3nLr2iyUspxc6A75f8Gn+rnPYOtROcvo1ZM2WhIbY1NS/X0eFYes8DINsLrHON93O05Zl3fOZNtgQnIC79NsL1hkvEgrqXtbMNkBZdC9pPRa9jqp1nQNWr7oO+5I0yv7t4TgE/ELHySRsYWPNzvqwEcra8onpOMt+RTauNHDjZlr0a1WDLGy0GYVoJNyxPbIs46hWx1Gt3leEx14MoodRYsVuD/qc7Zrj2FWfaWFa9Dsu1CH2rR4/KpymJWC4DSiif9ygXzbKi9fLIzof0aXVmo9EhnLACoeCSJxH3RolrI01agMzJpU6zI11Bs7m5Ldub+PyxlrXuY0g+CAIPiwkE9gvFHGfSS/jVMat31x+z7BclmW0WlLX8XuUfaglGf/NrvZnf2t2PQWjr89Hhec8lVAiFnV8irVxY/Tce41F40jlpeAG++smxtl2o6DXuNINO8bXabeXdjNq/ZrZ20ZDtDUlG3GGOopuOBTE+upKRwc8z+OR61c1KUK7wb6fjBJWq2b9gi3vNS8RDRzB7KIty8jl97CSWTI9hufPUtGlkgnk8nu2R8Rygv2t1mqaPR7WSa8bXi/fST3N4sS5j1vfI7vhxOesXGPabPlUOWCpYSM0cZub8H74Q7qUeN4f//GxOmBNE7PxOHwf/xiED37QUkpEq8j3suZ/29qC9P77nehcXDyOuaeexPFrr8P74Q9pjm0ZRBubZuSFBaR/5b/SlDVbLeyO8YuCYXlPla/Yw3FYSMSY9EFzeOz6FU1aDxZ2cGbTlHXDy2s3VNjUO8l4DNlcHvH5iMaJoCUd6xwZjDabeqUfYRe6BmGYOjsdO56PU/F5vVhkNv7cpt9e1MWmZnLu9ws6Ryirk1JWXy3puOvx/b6sDbN4NChW+nckFEQyHrUUgWMc9VHw8nOWI9SNKw3cOLkI+u1Fbq8ALz/X1eZyHNdxyEonE9i6mx3qq6Rx6sEp2DnHIc4g/XbHaK4Y8At9zSGN0gpPeg46Si1NYg5xUXGSfsOqDwv8goDiQcnUmaPVepD+S73J0SvKTDeSiVjXjQDlQ6dhrkFMhnpDxHs3tyyntFS+DnbyQjQwGf2OM9pGP3R7B57W9gfO3umvbK6bRh2RJAnVWr2vjS5iPDjJ/hLOwAkbzNM8XtrJOPTrVHt7ETiq1nQODBzH4dJyBu/euDXh2o2HUTuKFIpnUXd6ffjCcRxWMktoNETbIjI5xf6yY34oGLD8oV4yHsNCMoH11RUcVo7OIhmNMG0j4S6mzZa72gGLf+5ZeK5eBQDMra9DfPVV02hO8tYWGucOWWonrG5p9ghzZuNxzP+Tf2wa6Uo+OID07rsQnnmm73PLXVIbAkDr+9/XtJv3gx/E8Wuv69IPtv7mb/q+tpvx/+qvgWMGpO3sDk5OTydUo+FoyzJyewW0ZRmrmcVOOcdx2Fxd6RkJyw5KhxWNM1M0EkY2l0c4pF24LjroKy831pkA1lYymJ2Z0ZS5Wb9GsLmfA4JPF4Fi0huyCr0cuibBQiKmGQtZaGNtclwE/VrhTjaHuthEOBjo6RTl5edwbWMVf3vz9kBOQaQHwi5Iv71hU4zG5sN92eswE4HRiTbWTsjRcXw4Sb+Xlpc0i4OyLPeMhsbOjQfFw3G6r9VFsYliqaRZ8E+nkrbYRVmWNU6Mt25vOz7ymxvrrEad0jLgFxAKBREKBk3bcyGZQP58LcWpOEm/VphkHxq2/SVJAqD6EKpHlAI2SrU0IsfiRCKmc77aLxRxVK1pIqRcVAcsI4fugF/ouonLrq+M6iNGt+nXibC67BYxltXkMEwyUrQZdo6v02gv7eYi6tcoFTCruVGNl6OMBm1GvSFir1DUvB8Igg/pVFLnHMfq7/U33x74uv3eqyRJmvcns5TNXq8+reIgsPdq5DBk9R6OqjUcVWvwcByi0UhnnDEaY6PzEdscsJyiX6N0kYlErKfzpYfjNPO6+UgYXp7vOGA5ce5jh41i6zTpj9Od+JzVTJMtd7UDVugTn9BEXjqp13um02vfuGHb9WdCIdvO5TZ8H/+Yzvmq8eqrkN54A+23foSTgwMAgPDqX9p+7dZfvorQyy93/s0//DBm4/ELnX6w/fS/j/RP/5Sm7KB8iMqRexYVzdgvlhAQfJov0738HNZWlnBrWx8tjTWKN27fHdipo94QNWm4vPwcAn7BIJWfPmSmHYZsEKMxTJ3HjdH9dXtG05p+MB6dRySs3ZycFv2qYXXITpoaYtNyn29JEkKaReTufYONvjGOzV87+7eH47DMRJhqiE0USmXUVRtrS1021kapt2qtrolgeJG4KPq1yn6xhP1iCR6OQywaQUDwIRQMGqae5DiuE6WxH+zQg1uxc45DkH6tUq4cGTj371my2R6OQzI2rzvfpCEtuR+n6bchNjUbCPORMPL7ha4RIdgN1UEXMaPRiKY/S5I00i/cGwZRbY0WoT0cB6+Xt23DYRjcWGeWgF9AqyV15jrKBkfALyC1kNR9gW92j07Aafq1wqT70DDtz65N9YpSEApq26Y6olTVbPTJ7E6OIiCoaLUk3XwlFAqa9q1wKKjb+B3FGOBG/ToRvS6DJkf2dpo0wsyJgHVkcAJ2j6/TZC/tZhr0axRduRfhUFCTDhw4G0/VNMTmUPXqnIfpn0ba9nAcHnv0ese+Vms126OG5fcKOoeFpXQK5cOK5v2E1Z/ROrGiKXbeMOy9su9PRu2klGuuO2BbsfcaCgV1afDYftGNcCiIo+pZ9CZl/hLwC1haTA+cnq8bTtJvW5ZxUCprnKlSyQSq1VrXMTqzlNbNVYqlB23uxLmPHTaqIYoa22Nm171eHo88dLWjF1EUUTgo2R5l0onPmWVabPnspCswDO179zT/9j31FLjNza6/USJmKZxayAk7GzDevOEWzb+8n3aED35Q8+/qV7+K2uc+D+nb3+k4X42Kk4MDtN54o/Nvz8oKfB//mOYY8QJFvzrx+ZD4jX+gKZNlGffu706oRvZzJ5vTTa6ikTDi8xHdsexxZhNzD8dZmrQXmEhRa8tLGoNTrhwZfunePDdkaiJdJnERGw3ZoHUeN/WGaPkZGT2faeAsDLDWlkybfhXastzV8anRR4529jzh80VkM9hUh9Xa6CdkdvbvGLOx1pKO8c6NLewXS5YX9+2sD3vNbk4uAb8wkS++xsFF0q9VFNvalmXsF0u4k83hrXdv4I2338PdnV1dHwwM4Fhrhx7cit1znIsM6dc6rNM+x3G4trnWc2z3cBwur63o7EnhYPKbq6Qld+NE/bKL9xzHYWP1kulGZzIR00WtGtTJgdWYLJ/ojvFwXF+pNrvBzqNTyYTheJBOJXHtyiaefPxRPPn4o1hdydhy/UFwY50BYGPtUqcu165sIpGI6Y6pN0Tc3r5n8Gtn4kT9WmESfciu9jcanzJLacNjo/MR3bsd+3u7YFOKtNt6h7A0k2bnonHIOK2nkgnTeUlmUdum1Vrd9g07t+rXibDRQwTBp3MyAM42PbuluDLDzBHCrrmAndgxvk6jvbQbt+o3yuz99OMgozAf0e8fsecV+1iT7sZRtaZZ9xIEn+59IBo9u3YoGDj/r/97ssK9+zu6Mr2t0OovEddqx8NxuLyxhscevY4nH38U169e7tzPsPdqRfsejkPqPMWY2e+swrYxe69mZWrUY83ljTXduF1viNjbtz8doBP1m98vaNqfO+8r6VRS145eL4+NtUu6qKaSJOmc750297HDRlm1+cq4pOglHouOLMWv054zMJ223NUOWM3vfU/z7xlBQOS/+4ypE5bw0oua9IMAIL33Xs/r8A8/rCubjcd1TkgXCXXkMQA4qVZ1x/g/9cmRXV/60Y80/w585COaf7f+6q9Hdm2nMfvxF+BLawfB+7t7kI6nK73H1t2sbuM2s5jSGbwjZuE6nYwbGsXFVBIPX9nA048/gqcffwTrK0uG1y2VK5rrslFhyofmX/GzX/ink3FTQ7a8qF+AH9RJapg6jxujZ2Q02Wafz7SwvJgCP6eNDDON+lXo9pJU7+MLFqPN4JUl4z4SN1hELo1JA3b1byuhsa0sptlVnwrzkg2cRRsyqtPDVzbwxKMP4enHH8Fj1692dUR1GxdNv2bE5yN47PpVPP34I3ji0YdwbWNV168Uh6x8YXgnfbv04EbsnuNcZEi/1qk3RJ398As+XNtcMx3TfV4e1zbXdPa3WCo74iMA0pK7caJ+y4cViMxcVhB8eOShq7iyuY50Kol0KonlpTSuX72MlYy+LxUtOCf6BR88HAcPxxku2irXXV5Kd/p0dD6CK5vrOmcHKyhRugJ+obOhUiyWdIvtVzbXOwvGHo5DOpXEArNZYhQhely4oc5Gbct+oLKUTuk2DAG9k4qVFJiTwon6tcIk+pBd7d9qSdgvFDXHxGNRbKw9cBJV6r++qs10UK3VR9aXjNb3lL7v9fJIp5I6R9WLhtnmZlK1IRUOBXH96mVdOsdRbAC7Vb9OpN4QdY7X66srmrZNJmI6TZrBrrUJgg+rK5nOXCAcCg48Fxg1doyv02gv7cYt+mV1kV5IdmzVoHYhFAx09KD0J9ax0U5nY9axYWP1Umc/KBwK6u7hsDIaR+dWS0Iuv6cpm4+ENe8Q7H3HY9GOA43n3GFb/bFHW5Y1jhfD3GuZ2b/ieR5XNtc7v/d6ed24JYrNgaNl6qJdMf1idSXTM4q+fu6S1q0jsGOPHR+BO1G/Rv2L4zgspVN47NHruLK5jiub67h+9TIeeeiqoTPxvfs5XZnT5j522CgrNj+dSuqcDVl9GWH0vm4Fpz1nYDptuatTELa+8U20f+7nNKnnPCsriP/pn0B6/31I77wD4CyCFf/ww7qUeQAgvvqqrkx65x3w165pzhl65XdR/9Mv4uTgAPxzzyL40ks6J6SLxKkoYkYVKi/4i7+I02oV0re/A25zE94Pf0jn7GYn4te+juALL3TqoK5LO5uFvLU1sms7iXYmg8zffVFT1hCb2LNhg9NpNFsS8oUDZFRph7z8HBYSMeRUYVr3iyWkk/HO5FD5Sj+/X8TBYQUejsNCIqZJpQKYpyRryzLKlSPDjdyWdIyDLhP03f0iopGwti4bq7if38f++WQxEgpieTGlc5La3S/qzmeVYeo8bkqH2npyHIeHr24iXyii1ZLOFt6SCcP0VW7HL/iQYvrhtOpXoS42kTD5Wz8TJWU8UOs4EYuC4zjc391DsyV1tJ5hUpVVa3Xb0wwpGybA2YRXOf+o+rdf8GFlKY3d8/zW8fkI0gu9z2NnfdjxWPn/0mEFzZaEgF/A2rJ2c9HDzU5NhKKLqF8zKtUaVlVfYnHnUW9ubWc1Icp9Xl5nl1gnCBYzbbHHDKIHN2L3HGcUWGmzSUP67Z/tbA7hYECz+OoXfLi6sYqG2MRRrd5ZvIlGwoZpbFvSMbK5PV25EUrfCfgFyLJsu9OWG7REGONk/d67v4PLG2u6iFTKF6zd2C8UDefCbGoP7jyNB/DAMaJ8WNFtbiwkE7pFYBYjnVZrdV2qEuXct25vd9KP5PJ7GicyQfBhfXXFdKNYFJu2p1bpByfW2UrbFoslJGJRzcbT+uoKMoupznjkF3y6PrdXGHwtYZQ4Wb+9mEQfsrP9lVRE6g2U+Ui4a2QdUWzizgi/MD+sHGkiIfA8j8sbaz1/59QUI6NA2dxU9zuO47CSWTJ05FXI7uRsf0Zu1q9Tye3mce3KgyACVtrWjGq1BjBzgXgsqos2wqYccgJ2jK/TZi/txk36rdZqTPq2sw8aFAbpw7IsG+pB4bByZOta5U4uj3nVfpAg+DRaVzOMQ5EVjLSRWUzjqHqWrlxx0la/N6jn/yys48Uw99qWZdy7n9PovNvvzyI+6aN6WaXeEHFYOdLMfdh+0at/Gd2vOsUiO87IsozikO3rZP0q7Wlkt3q9/5rNVZw09wHsewfI7eY1awW97kmWZezk8rpyK+/rVnDacwam05a72gELAKpf/CLmX3lF44ADAPy1axonKiMar74K6dvf0ZUf//CHAOM8JDzzDIRnntGUsU5IF4nma69pngcXj2P+M58BPvOZrr/zXL1q+MztqEOn/Ac/sOX8jmdmBsFf/3XMeLQy3r53H6enpxOq1GjJ7RV0mzqZ9AIqqvzCbVnG/fw+VjMPNoP9gg8bq8vYWF02PG9DbGqcuFj2D8qGzkxsNACWZkvS1YXjOKxmFjVlLHd3dofesBy0zuOmUq3pHGm8/Jzu+cjn6euMNgrcytqlZczMzGjKplm/gD51ncIgm6u7ewWEgwFNn4hGwoh2WURuiE3c2s72dR0j2PvgOA5PPPoQAK2Dl139u3RY0TmSpZNx3cYwC3s+O/W2XywZjsdsPdXcvb+rcchxMxdRv2a0ZVnnkBcKBvDEow91FiE4jtP1p5Z03HFGVrCiLbv04EZGMccZFqvjoZMg/fZPW5bx/u27uLaxqlvs8Au+nvqSZRlbd7OmNoBdRFLbkxu379rugOVELRHWcLJ+6w0Rt25vY311pa8IE/uFIu4bLK4CZ046ZhsBirNrqyUhu5PruWGb3clhKZ3SLPp6vbxmkZbd9FKjrkOhWOp84dwLUWzi5tadnseNGqfV2UrbtmUZd+5mcWk5o3Gc4XnetI/tF4oTdXbrhpP1a4Vx9yE7278ty7i5dQfra5d6bogBD+o/yne3nVwefkHQfVXP1qNc0TqZeh0YwWeUKJub6vG7G9md3Eg2892uXydSb4g97bcsy9grFHuOO/WGqHOiYBHFJvL7BctRtcbJsOPrtNlLu3GTfovFElLJhOl4xzoMWKHbb0SxiXvZwZ16jGjLMm7d3jb8MEPNsA5FVuuyVyjqnEeSiVjHVtzP5SEIwkAOM8Pea/mwAo+H69mm8vl1hnWUu5fdgZfnTecevfqX2f0aPTulzsPOpZyu30KxhEZDxNJi2tIcU5Ik7OzudY0655S5j7o+w74DKGsFvbQCdO87Vt/XreC05zyNttzVKQgB4Pi113H42c9CPujP47Px6quofe7zpudsGETGUtPOZnH0la/0dc1pov6nX0Q7230Tu53NovYXf6Ep4xbMN2b7RXrzTcPyi5J+sP1Tz2D+qSc1ZYWDEqr1xoRqNB62DUJTslFW9osl7OT3LZ2vITbx/tZ212PqDRENg/RoBQtpIvaLJdzd2TVMkWTE3Z1d3Yb0IAxT53GTzeVRLJVN/96SjvH+7buWn6EbSMZjCAX8mrKLoN/6+UYDS68oOEa0ZRnvb23rQriaoWjdjkVks/sA9JNdO/p3syXh7k7vvO7sWMNxHHxM+Fm79NY+30w3GmfM6uak6HvDcFH1243cXsHQ7ipRP4ycr4ycMaxoy049uBG75zjD0s946ARIv4NTb4h4692blu2uQrVWx1vv3uy6WNptHmCUGtAOnKYlojdu0G+9IeK9G1vI5fd0KQnVyLKMg1IZt25vmzpfAQ8W+Y3OxXEPlvMKxRLu3M1CMkh3dlg5wvs3t1AolnRpDNiQ/vm9AvYLReP0vh5Od+yt29umqREk6eyr2lE7cfSDk+pstW3rDRHv3rjVs08dVo569qdJ4gb9WmHcfcjO9lecsLrVXxSbyO7k8O6NW2PRwM2tOzgweDdVnuO7N27pNujmI+GRzQ2cSqFYwjvv3kAuv2c4zis25Z33boxkY2xa9OtECsUSbt02Xtc6rBzhvZtbuoiJZtzP5ZHL7+lsuHwevePm1h1Hr6sOO75Oi720G7fpV5kfsZqQJAm3bm8PNMaZzZMPSuWRzfnqDRHv3dwytHHKtd9598ZYsgQUiiXd81xKpzS29ObWHVMbI4rNrs9+2HstFEt4570bOCiVDceog1IZ793csuVZmc09JEnCnbtZS/1Lfb9mY6pddXaLfusNsTPHPCiVdWOwJEk4rBwhu5PD2+/esJTyc9JzHxY73gHqDRHvvGve1zv31EUv/byvW8Fpz3nabLnrI2ABZw5T5X/w6/B9/GPwPf20YapB4CxiVfO119D67nd7RmGqfe7zOKnXEfjIRzRRrk5FEfVvfQvN/+P/hOexH7PzNlzFycEBDv/bzyDwa7+qt2+olAAACUdJREFUi0IlHxxA/Ju/QeNLXwa3ualJReh76inU43Gc9OkwZ0TrG9/E6a/8iqZ9pPffvxDpB08CASz8+t/XlLXbMu7tOHvAsYN6Q9RFcPELPiylkpqv0nN7BdQbIpLxqGFEnJZ0jGKpjP1iydJEu1Aqa76Sr9bqlr/G3y+WUCpXsJCIIRGL6tIiyecpA3f3i7Z+4T9MncfNnWwOdbGJWCTc8eLut43cgsfD4VImrSm7KPoFzjZZWU1adeJhacsy3tvaRiQUNNV6Q2yicN6P7EKJBLK2vKRzLDFyOLCjf+8XS5DbMjKLKd0Yoowf9YaIgODTRL+LzUd0ETvs0luzJeH9rW3TsU2pW+Gg7MgoOINw0fXbjdxeAZVqDQvnWjTSQq9+ZlVbdurBjdg9xxmGfsfDSUL6HR613Y3Nh021rsxtS4dHlsb/3F4BHMchGZvXnY8bYBHJKk7SEtEdN+m3LcvI7xU6X2KGQ0HN3xsNsa/+pCxCer18J/KL0TnKhxWUDytdj7ub3cHdHl/538/lcT+X79RblmXTBeCjaq3zJXzAL3T025KkrukPjqo1vP7m213rAcBSBCGr51IfP0idrdannzpZbVsApn2qW/s4hUnot99+0e+5B+1Dg9bLzvZX1199Lqtjk506aMtyZ1wyG3NaLanreeyIVqd+vsNex8p9D9IP1LZFPWaMegxwk/0dFrvsEtBfGyua9HAc/P6zPQ61HvuJ+qb0EWVsYvuHlXr1usdB7G6/zwLof3xVcLO9tJtx6ddue6s4cyhjHdt2va5n9Hdlnqz0q142r9s1rNgM4Mx+sTYOwNDpuwZ53lbGLiMbY1V7w97rML+32h4KytxjJ5eH3y/03b/Y+qrHKjvHGTfaX/UYbgfDzn3snpPZYaPUc99Bz2Hlfb2f+fE4nnO/9ZoWWz6z+6EPOyNWnc3wzz2r+Xf7rR8N7PQz99STmAmHcXp0hOPXXrehdtOH8rzH/YziX/8auPgDR5zqV78K8WtfH9v1J8XMJz6J1H/5gqbszr37tjoYTBsBv/AgTYMkTdQRyacyZG2XGY1J8tDmmibE5k5+35Ub6euXlrGQiGnKSL/2EVFNyup9bnANglrPw1yvn/5t1zXtqo+Ch+MQ8D9wip4Wpys1pF/rqPsp0H9ftdrPx6EHp+OUOY7T24L0OxpYrQ/bBxU7Pok5slO0ROgh/RKEeyH9EoR7If1OnnAoiMsba5qyUTmYEtMF6Zcg3AvplyDcz1REwDKiV4SrfiCnq97Y+bytwj/3rMb5CgBaf9k9deQ00F5fx/J/8XFNWa3eIOPbAyc5OTVbtKGj8NDmGnie74S4PKrVUTqsGD4fNrKGk9rUKsGAXzd5Jv3ay7idfrrpeVT9e9AxZNR6a8vyVDpdKZB++2NYW2f192RTnWMPndwWpN/RYXe7T9KOOEVLhBbSL0G4F9IvQbgX0i9BuBfSL0G4F9IvQUwHU+uARUw3s/E4gi+9pClrvfGGLakNHc3sLCK/+RvAzEyn6PT0FHfudU8jQBBOpS3LCPFznRRSoWAAfsGHW9tZzXErS2ldShq3bZLNzMxg/VJGU0b6nW6c1r+dVh83QfolCPdC+iUI90L6JQj3QvolCPdC+iUI90L6JQj3QvoliOmBHLAI1+D/1CfBP/IIAIC/dk33d/HV6Y9+JX/oQwidPwOFvcIBGuLF3hgn3Ev58AjRSFhTFo2E8dj1q50oPX7Bp3MGKZbKjktt1ItUMg6/IGjKSL/TjdP6t9Pq4yZIvwThXki/BOFeSL8E4V5IvwThXki/BOFeSL8E4V5IvwQxPZADFuEqjByvgLPoV5NIgzhO5HAYqV/7VU3Z8fEx7u/uTahGBDE8B4cVhEMBJGJRTblXFaWHpSE2kc25q9/Pzc1heTGlKSP9Tj9O699Oq49bIP0ShHsh/RKEeyH9EoR7If0ShHsh/RKEeyH9EoR7If0SxHRBDliEa2jfuGFYLn73u6j/6RfHXJvxw/+9vwdPKKQpu3t/F/IFj0pCuJ872Rxa0jESsaipE4hCsVRGNrfnumg8q8uLuqhCpN+LgdP6t9Pq4wZIvwThXki/BOFeSL8E4V5IvwThXki/zqLREHHr9vakq0G4BNIvQbgX0i9BTBfkgEW4hvZbP0L1q1/FTDAIADit1SD9u+9D3tqacM1GT/vaQ0j/7H+mKTuq1nBQPpxQjQjCXnJ7BeT2Cgj4BQT8AjzMZLPeEFFviK50BAmHgohH5zVlpN+LhdP6t9Pq42RIvwThXki/BOFeSL8E4V5IvwThXki/zqMtyziq1iZdDcIFkH4Jwr2Qfgli+iAHLMI1nBwcQPza1yddjbFz6vEg+lu/qSk7OT3FdnZnQjUiiNGhOH5MC7MzM1hbyWjKSL8XF6f1b6fVx2mQfgnCvZB+CcK9kH4Jwr2QfgnCvZB+CcK9kH4Jwr2QfgliOpmddAUIgujO6c/8DAKXNzVl+b0CxGZrQjUiCMIq6VQSgs+rKSP9EoQ7IP0ShHsh/RKEeyH9EoR7If0ShHsh/RKEeyH9EoR7If0SxHRCDlgE4WDkWAypT/zXmrKWJGEnvz+hGhEEYRUvzyOTXtCUkX4Jwh2QfgnCvZB+CcK9kH4Jwr2QfgnCvZB+CcK9kH4Jwr2QfglieiEHLIJwML5PfQqcIGjK7mZzODk5mVCNCIKwyurKEmZntWaW9EsQ7oD0SxDuhfRLEO6F9EsQ7oX0SxDuhfRLEO6F9EsQ7oX0SxDTCzlgEYRDaT/+OOIf+juasnLlCOXK0YRqRBCEVaKRMKKRsKaM9EsQ7oD0SxDuhfRLEO6F9EsQ7oX0SxDuhfRLEO6F9EsQ7oX0SxDTDTlgEYQDOZ3jEf/N39CUnZyc4G42N6EaEQRhldnZWayuLGnKSL8E4Q5IvwThXki/BOFeSL8E4V5IvwThXki/BOFeSL8E4V5IvwQx/XjsOtGJ4LfrVARx4Zn92McgrKxoynb3CpBlGR6Om1CtCIKwQmYxBS/Pa8pIvwThDki/BOFeSL8E4V5IvwThXki/BOFeSL8E4V5IvwThXki/BOEe2rI80O8oAhZBOIyT1AIWXvolTVmz1cJe8WBCNSIIwio+nxepZFxTRvolCHdA+iUI90L6JQj3QvolCPdC+iUI90L6JQj3QvolCPdC+iWIi8H/D5ltiYQX10mIAAAAAElFTkSuQmCC'"/>
            </xsl:call-template>
        </fo:marker>
        <xsl:text>1. Summary</xsl:text>
    </fo:block>

    <fo:block xsl:use-attribute-sets="class-paragraph">
        <xsl:text>Review this summary for a quick view of key information contained in your Equifax Credit Report.</xsl:text>
    </fo:block>

    <fo:block xsl:use-attribute-sets="class-paragraph">
        <fo:table xsl:use-attribute-sets="class-table">
            <fo:table-column column-width="40%" />
            <fo:table-column column-width="60%" />
            <fo:table-body>
                <fo:table-row xsl:use-attribute-sets="class-row-odd">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Report Date
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:call-template name="func-formatDate">
                                <xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate" />
                                <xsl:with-param name="mode" select="'mmm dd, yyyy'" />
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-even">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Credit File Status
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:choose>
                            <xsl:when test="(/printableCreditReport/creditReport/providerViews/summary/creditFileSecurityFreezeFlag='true') or ((/printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert) and /printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert!='') or ((/printableCreditReport/creditReport/providerViews/summary/fileStatus) and /printableCreditReport/creditReport/providerViews/summary/fileStatus!='')">
                                <xsl:if test="/printableCreditReport/creditReport/providerViews/summary/creditFileSecurityFreezeFlag='true'">
                                    <fo:block xsl:use-attribute-sets="class-cell">
                                        Security Freeze in Place
                                    </fo:block>
                                </xsl:if>
                                <xsl:if test="((/printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert) and /printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert!='')">
                                    <fo:block xsl:use-attribute-sets="class-cell">
                                        <xsl:value-of select="/printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert" />
                                    </fo:block>
                                </xsl:if>
                                <xsl:if test="((/printableCreditReport/creditReport/providerViews/summary/fileStatus) and /printableCreditReport/creditReport/providerViews/summary/fileStatus!='')">
                                    <fo:block xsl:use-attribute-sets="class-cell">
                                        <xsl:value-of select="/printableCreditReport/creditReport/providerViews/summary/fileStatus" />
                                    </fo:block>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:block xsl:use-attribute-sets="class-cell">
                                    No fraud indicator on file
                                </fo:block>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-odd">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Alert Contacts
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:value-of select="count(/printableCreditReport/creditReport/providerViews/summary/subject/alertContacts)"/>
                            <xsl:text> Records Found</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-even">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Average Account Age
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:call-template name="func-calcAge">
                                <xsl:with-param name="totalMonths" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/averageAccountAgeMonths" />
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-odd">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Length of Credit History
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:call-template name="func-calcAge">
                                <xsl:with-param name="totalMonths" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/lengthOfCreditHistoryMonths" />
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-even">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Accounts with Negative Information
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalNegativeAccounts" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-odd">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Oldest Account
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/oldestAccountName" />
                            <xsl:if test="(/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/oldestAccountOpenDate) and (/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/oldestAccountOpenDate!='')">
                                <fo:inline> (Opened  </fo:inline>
                                <fo:inline>
                                    <xsl:call-template name="func-formatDate">
                                        <xsl:with-param name="date" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/oldestAccountOpenDate" />
                                        <xsl:with-param name="mode" select="'mmm dd, yyyy'" />
                                    </xsl:call-template>
                                </fo:inline><fo:inline>)</fo:inline>
                            </xsl:if>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row xsl:use-attribute-sets="class-row-even">
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-label class-cell">
                            Most Recent Account
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="class-cell">
                            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mostRecentAccountName" />
                            <xsl:if test="(/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mostRecentAccountOpenDate) and (/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mostRecentAccountOpenDate!='')">
                                <fo:inline> (Opened  </fo:inline>
                                <fo:inline>
                                    <xsl:call-template name="func-formatDate">
                                        <xsl:with-param name="date" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mostRecentAccountOpenDate" />
                                        <xsl:with-param name="mode" select="'mmm dd, yyyy'" />
                                    </xsl:call-template>
                                </fo:inline><fo:inline>)</fo:inline>
                            </xsl:if>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </fo:block>


    <xsl:if test="$scoreEnabled">
        <xsl:variable name="creditScoreData" select="/printableCreditReport/creditReport/providerViews/summary/creditScore" />
        <xsl:if test="not(normalize-space($creditScoreData)='')">
            <xsl:call-template name="section-creditScore" />
        </xsl:if>
    </xsl:if>

    <!-- ============== CREDIT ACCOUNTS ============== -->
    <fo:block>
        <fo:block xsl:use-attribute-sets="class-h2">
            <xsl:text>Credit Accounts</xsl:text>
        </fo:block>

        <fo:block xsl:use-attribute-sets="class-paragraph">
            <xsl:text>Your credit report includes information about activity on your credit accounts that may affect your credit score and rating.</xsl:text>
        </fo:block>

        <fo:block xsl:use-attribute-sets="class-paragraph">
            <fo:table xsl:use-attribute-sets="class-table">
                <fo:table-column column-width="1.0in" />
                <fo:table-column column-width="0.5in" />
                <fo:table-column column-width="1.0in" />
                <fo:table-column column-width="1.0in" />
                <fo:table-column column-width="1.0in" />
                <fo:table-column column-width="1.0in" />
                <fo:table-column column-width="1.0in" />
                <fo:table-column column-width="1.0in" />
                <fo:table-body>
                    <fo:table-row xsl:use-attribute-sets="class-row-header">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Account Type</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Open</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>With Balance</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Total Balance</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Available</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Credit Limit</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Debt-to-Credit</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:text>Payment</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                    <xsl:call-template name="func-reportSummary-itemFormat">
                        <xsl:with-param name="node" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/revolvingAccounts" />
                        <xsl:with-param name="bgColor" select="$colorOddRowBG" />
                        <xsl:with-param name="accountType" select="'Revolving'" />
                    </xsl:call-template>

                    <xsl:call-template name="func-reportSummary-itemFormat">
                        <xsl:with-param name="node" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mortgageAccounts" />
                        <xsl:with-param name="bgColor" select="$colorEvenRowBG" />
                        <xsl:with-param name="accountType" select="'Mortgage'" />
                    </xsl:call-template>

                    <xsl:call-template name="func-reportSummary-itemFormat">
                        <xsl:with-param name="node" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/installmentAccounts" />
                        <xsl:with-param name="bgColor" select="$colorOddRowBG" />
                        <xsl:with-param name="accountType" select="'Installment'" />
                    </xsl:call-template>

                    <xsl:call-template name="func-reportSummary-itemFormat">
                        <xsl:with-param name="node" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/otherAccounts" />
                        <xsl:with-param name="bgColor" select="$colorEvenRowBG" />
                        <xsl:with-param name="accountType" select="'Other'" />
                    </xsl:call-template>

                    <xsl:call-template name="func-reportSummary-itemFormat">
                        <xsl:with-param name="node" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalOpenAccounts" />
                        <xsl:with-param name="bgColor" select="$colorEvenRowBG" />
                        <xsl:with-param name="accountType" select="'Total'" />
                    </xsl:call-template>

                </fo:table-body>
            </fo:table>
        </fo:block>
    </fo:block>

    <!-- ============== OTHER CREDIT ITEMS ============== -->
    <fo:block>
        <fo:block xsl:use-attribute-sets="class-h2">
            <xsl:text>Other Items</xsl:text>
        </fo:block>

        <fo:block xsl:use-attribute-sets="class-paragraph">
            <xsl:text>Your credit report includes your Personal Information and, if applicable, Consumer Statements, and could include other items that may affect your credit score and rating.</xsl:text>
        </fo:block>

        <fo:block xsl:use-attribute-sets="class-paragraph">
            <fo:table xsl:use-attribute-sets="class-table">
                <fo:table-column column-width="40%" />
                <fo:table-column column-width="60%" />
                <fo:table-body>
                    <fo:table-row xsl:use-attribute-sets="class-row-odd">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-label class-cell">
                                Consumer Statements
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell class-cell-right">
                                <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalConsumerStatements" />
                                <xsl:text> Statements Found</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="class-row-even">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-label class-cell">
                                Personal Information
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell class-cell-right">
                                <xsl:value-of select="(/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalPersonalInformation) + count(/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/alertContacts)" />
                                <xsl:text> Items Found</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="class-row-odd">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-label class-cell">
                                Inquiries
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell class-cell-right">
                                <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalInquires" />
                                <xsl:text> Inquiries Found</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="class-row-even">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-label class-cell">
                                Most Recent Inquiry
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell">
                                <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mostRecentInquiryName" />
                                <fo:inline>
                                    <xsl:call-template name="func-formatDate">
                                        <xsl:with-param name="date" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/mostRecentInquiryDate" />
                                        <xsl:with-param name="mode" select="'mmm dd, yyyy'" />
                                    </xsl:call-template>
                                </fo:inline>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="class-row-even">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-label class-cell">
                                Public Records
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell class-cell-right">
                                <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalPublicRecords" />
                                <xsl:text> Records Found</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="class-row-odd">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-label class-cell">
                                Collections
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-cell class-cell-right">
                                <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/totalCollections" />
                                <xsl:text> Collections Found</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </fo:block>


</xsl:template>