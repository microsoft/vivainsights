# Simulate a person-to-person query using a Watts-Strogatz model

Generate an person-to-person query / edgelist based on the graph
according to the Watts-Strogatz small-world network model.
Organizational data fields are also simulated for `Organization`,
`LevelDesignation`, and `City`.

## Usage

``` r
p2p_data_sim(dim = 1, size = 300, nei = 5, p = 0.05)
```

## Arguments

- dim:

  Integer constant, the dimension of the starting lattice.

- size:

  Integer constant, the size of the lattice along each dimension.

- nei:

  Integer constant, the neighborhood within which the vertices of the
  lattice will be connected.

- p:

  Real constant between zero and one, the rewiring probability.

## Value

data frame with the same column structure as a person-to-person flexible
query. This has an edgelist structure and can be used directly as an
input to
[`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md).

## Details

This is a wrapper around
[`igraph::watts.strogatz.game()`](https://r.igraph.org/reference/watts.strogatz.game.html).
See igraph documentation for details on methodology. Loop edges and
multiple edges are disabled. Size of the network can be changing the
arguments `size` and `nei`.

## See also

Other Data:
[`g2g_data`](https://microsoft.github.io/vivainsights/reference/g2g_data.md),
[`mt_data`](https://microsoft.github.io/vivainsights/reference/mt_data.md),
[`p2p_data`](https://microsoft.github.io/vivainsights/reference/p2p_data.md),
[`pq_data`](https://microsoft.github.io/vivainsights/reference/pq_data.md)

Other Network:
[`g2g_data`](https://microsoft.github.io/vivainsights/reference/g2g_data.md),
[`network_g2g()`](https://microsoft.github.io/vivainsights/reference/network_g2g.md),
[`network_p2p()`](https://microsoft.github.io/vivainsights/reference/network_p2p.md),
[`network_summary()`](https://microsoft.github.io/vivainsights/reference/network_summary.md),
[`p2p_data`](https://microsoft.github.io/vivainsights/reference/p2p_data.md)

## Examples

``` r
# Simulate a p2p dataset with 800 edges
p2p_data_sim(size = 200, nei = 4)
#>     PrimaryCollaborator_PersonId SecondaryCollaborator_PersonId
#> 1                       SIM_ID_1                       SIM_ID_2
#> 2                       SIM_ID_2                       SIM_ID_3
#> 3                       SIM_ID_3                       SIM_ID_4
#> 4                       SIM_ID_4                       SIM_ID_5
#> 5                       SIM_ID_5                       SIM_ID_6
#> 6                       SIM_ID_6                       SIM_ID_7
#> 7                       SIM_ID_7                       SIM_ID_8
#> 8                       SIM_ID_8                       SIM_ID_9
#> 9                       SIM_ID_9                      SIM_ID_10
#> 10                     SIM_ID_11                      SIM_ID_55
#> 11                     SIM_ID_11                      SIM_ID_12
#> 12                     SIM_ID_12                      SIM_ID_13
#> 13                     SIM_ID_13                      SIM_ID_14
#> 14                     SIM_ID_14                      SIM_ID_15
#> 15                     SIM_ID_15                      SIM_ID_16
#> 16                     SIM_ID_16                      SIM_ID_17
#> 17                     SIM_ID_17                      SIM_ID_18
#> 18                     SIM_ID_18                      SIM_ID_19
#> 19                     SIM_ID_19                      SIM_ID_20
#> 20                     SIM_ID_20                      SIM_ID_21
#> 21                     SIM_ID_21                      SIM_ID_22
#> 22                     SIM_ID_22                      SIM_ID_23
#> 23                     SIM_ID_23                      SIM_ID_24
#> 24                     SIM_ID_24                      SIM_ID_25
#> 25                     SIM_ID_25                      SIM_ID_26
#> 26                     SIM_ID_26                      SIM_ID_27
#> 27                     SIM_ID_27                      SIM_ID_28
#> 28                     SIM_ID_28                      SIM_ID_29
#> 29                     SIM_ID_29                      SIM_ID_30
#> 30                     SIM_ID_30                      SIM_ID_31
#> 31                     SIM_ID_31                      SIM_ID_32
#> 32                     SIM_ID_32                      SIM_ID_33
#> 33                     SIM_ID_33                      SIM_ID_34
#> 34                     SIM_ID_35                      SIM_ID_82
#> 35                     SIM_ID_35                      SIM_ID_36
#> 36                     SIM_ID_36                      SIM_ID_37
#> 37                     SIM_ID_37                      SIM_ID_38
#> 38                     SIM_ID_38                      SIM_ID_39
#> 39                     SIM_ID_39                      SIM_ID_40
#> 40                     SIM_ID_40                      SIM_ID_41
#> 41                     SIM_ID_41                      SIM_ID_42
#> 42                     SIM_ID_43                     SIM_ID_153
#> 43                     SIM_ID_43                      SIM_ID_44
#> 44                     SIM_ID_44                      SIM_ID_45
#> 45                     SIM_ID_45                      SIM_ID_46
#> 46                     SIM_ID_46                      SIM_ID_47
#> 47                     SIM_ID_47                      SIM_ID_48
#> 48                     SIM_ID_48                      SIM_ID_49
#> 49                     SIM_ID_49                      SIM_ID_50
#> 50                     SIM_ID_50                      SIM_ID_51
#> 51                     SIM_ID_51                      SIM_ID_52
#> 52                     SIM_ID_52                      SIM_ID_53
#> 53                     SIM_ID_53                      SIM_ID_54
#> 54                     SIM_ID_54                      SIM_ID_55
#> 55                     SIM_ID_55                     SIM_ID_183
#> 56                     SIM_ID_56                      SIM_ID_57
#> 57                     SIM_ID_57                      SIM_ID_58
#> 58                     SIM_ID_58                      SIM_ID_59
#> 59                     SIM_ID_59                      SIM_ID_60
#> 60                     SIM_ID_60                      SIM_ID_61
#> 61                     SIM_ID_51                      SIM_ID_62
#> 62                     SIM_ID_62                      SIM_ID_63
#> 63                     SIM_ID_63                      SIM_ID_64
#> 64                     SIM_ID_64                      SIM_ID_65
#> 65                     SIM_ID_65                      SIM_ID_66
#> 66                     SIM_ID_66                      SIM_ID_67
#> 67                     SIM_ID_67                      SIM_ID_68
#> 68                     SIM_ID_68                      SIM_ID_69
#> 69                     SIM_ID_69                      SIM_ID_70
#> 70                     SIM_ID_70                      SIM_ID_71
#> 71                     SIM_ID_71                      SIM_ID_72
#> 72                     SIM_ID_72                      SIM_ID_91
#> 73                     SIM_ID_73                      SIM_ID_74
#> 74                     SIM_ID_74                      SIM_ID_75
#> 75                     SIM_ID_75                      SIM_ID_76
#> 76                     SIM_ID_76                      SIM_ID_77
#> 77                     SIM_ID_77                      SIM_ID_78
#> 78                     SIM_ID_78                      SIM_ID_79
#> 79                     SIM_ID_79                      SIM_ID_80
#> 80                     SIM_ID_80                      SIM_ID_81
#> 81                     SIM_ID_81                      SIM_ID_82
#> 82                     SIM_ID_82                      SIM_ID_83
#> 83                     SIM_ID_83                      SIM_ID_84
#> 84                     SIM_ID_84                      SIM_ID_85
#> 85                     SIM_ID_85                      SIM_ID_86
#> 86                     SIM_ID_86                      SIM_ID_87
#> 87                     SIM_ID_87                      SIM_ID_88
#> 88                     SIM_ID_88                      SIM_ID_89
#> 89                     SIM_ID_89                      SIM_ID_90
#> 90                     SIM_ID_90                      SIM_ID_91
#> 91                     SIM_ID_91                      SIM_ID_92
#> 92                     SIM_ID_92                      SIM_ID_93
#> 93                     SIM_ID_93                      SIM_ID_94
#> 94                     SIM_ID_41                      SIM_ID_95
#> 95                     SIM_ID_95                     SIM_ID_189
#> 96                     SIM_ID_96                      SIM_ID_97
#> 97                     SIM_ID_97                      SIM_ID_98
#> 98                     SIM_ID_98                      SIM_ID_99
#> 99                     SIM_ID_39                     SIM_ID_100
#> 100                   SIM_ID_100                     SIM_ID_101
#> 101                   SIM_ID_101                     SIM_ID_102
#> 102                   SIM_ID_102                     SIM_ID_103
#> 103                   SIM_ID_103                     SIM_ID_104
#> 104                   SIM_ID_104                     SIM_ID_105
#> 105                   SIM_ID_105                     SIM_ID_106
#> 106                   SIM_ID_106                     SIM_ID_107
#> 107                   SIM_ID_107                     SIM_ID_108
#> 108                   SIM_ID_108                     SIM_ID_109
#> 109                   SIM_ID_109                     SIM_ID_110
#> 110                   SIM_ID_110                     SIM_ID_179
#> 111                   SIM_ID_112                     SIM_ID_173
#> 112                   SIM_ID_112                     SIM_ID_113
#> 113                   SIM_ID_113                     SIM_ID_114
#> 114                   SIM_ID_114                     SIM_ID_115
#> 115                   SIM_ID_115                     SIM_ID_116
#> 116                   SIM_ID_116                     SIM_ID_117
#> 117                   SIM_ID_117                     SIM_ID_118
#> 118                   SIM_ID_118                     SIM_ID_119
#> 119                   SIM_ID_119                     SIM_ID_120
#> 120                   SIM_ID_120                     SIM_ID_121
#> 121                   SIM_ID_121                     SIM_ID_122
#> 122                   SIM_ID_122                     SIM_ID_123
#> 123                   SIM_ID_123                     SIM_ID_124
#> 124                   SIM_ID_124                     SIM_ID_125
#> 125                   SIM_ID_125                     SIM_ID_126
#> 126                   SIM_ID_126                     SIM_ID_127
#> 127                   SIM_ID_127                     SIM_ID_128
#> 128                   SIM_ID_128                     SIM_ID_129
#> 129                   SIM_ID_129                     SIM_ID_130
#> 130                   SIM_ID_130                     SIM_ID_131
#> 131                   SIM_ID_131                     SIM_ID_132
#> 132                   SIM_ID_132                     SIM_ID_133
#> 133                   SIM_ID_133                     SIM_ID_134
#> 134                   SIM_ID_134                     SIM_ID_135
#> 135                   SIM_ID_135                     SIM_ID_136
#> 136                   SIM_ID_136                     SIM_ID_137
#> 137                   SIM_ID_137                     SIM_ID_138
#> 138                   SIM_ID_138                     SIM_ID_139
#> 139                   SIM_ID_139                     SIM_ID_140
#> 140                   SIM_ID_140                     SIM_ID_141
#> 141                   SIM_ID_141                     SIM_ID_142
#> 142                   SIM_ID_142                     SIM_ID_143
#> 143                   SIM_ID_143                     SIM_ID_144
#> 144                   SIM_ID_144                     SIM_ID_145
#> 145                   SIM_ID_145                     SIM_ID_146
#> 146                   SIM_ID_146                     SIM_ID_147
#> 147                   SIM_ID_147                     SIM_ID_148
#> 148                   SIM_ID_148                     SIM_ID_149
#> 149                   SIM_ID_149                     SIM_ID_150
#> 150                   SIM_ID_150                     SIM_ID_151
#> 151                   SIM_ID_151                     SIM_ID_152
#> 152                   SIM_ID_152                     SIM_ID_153
#> 153                   SIM_ID_153                     SIM_ID_154
#> 154                   SIM_ID_154                     SIM_ID_155
#> 155                   SIM_ID_155                     SIM_ID_156
#> 156                   SIM_ID_156                     SIM_ID_157
#> 157                   SIM_ID_157                     SIM_ID_158
#> 158                   SIM_ID_158                     SIM_ID_159
#> 159                   SIM_ID_159                     SIM_ID_160
#> 160                   SIM_ID_160                     SIM_ID_161
#> 161                    SIM_ID_69                     SIM_ID_161
#> 162                   SIM_ID_162                     SIM_ID_163
#> 163                    SIM_ID_39                     SIM_ID_164
#> 164                   SIM_ID_164                     SIM_ID_165
#> 165                   SIM_ID_165                     SIM_ID_166
#> 166                   SIM_ID_166                     SIM_ID_167
#> 167                   SIM_ID_167                     SIM_ID_168
#> 168                   SIM_ID_168                     SIM_ID_169
#> 169                   SIM_ID_169                     SIM_ID_170
#> 170                    SIM_ID_91                     SIM_ID_170
#> 171                   SIM_ID_171                     SIM_ID_172
#> 172                    SIM_ID_99                     SIM_ID_172
#> 173                   SIM_ID_173                     SIM_ID_174
#> 174                   SIM_ID_123                     SIM_ID_175
#> 175                   SIM_ID_175                     SIM_ID_176
#> 176                   SIM_ID_177                     SIM_ID_195
#> 177                   SIM_ID_177                     SIM_ID_178
#> 178                   SIM_ID_178                     SIM_ID_179
#> 179                   SIM_ID_179                     SIM_ID_180
#> 180                   SIM_ID_180                     SIM_ID_181
#> 181                   SIM_ID_181                     SIM_ID_182
#> 182                   SIM_ID_182                     SIM_ID_183
#> 183                   SIM_ID_115                     SIM_ID_183
#> 184                   SIM_ID_184                     SIM_ID_185
#> 185                   SIM_ID_185                     SIM_ID_186
#> 186                   SIM_ID_186                     SIM_ID_187
#> 187                   SIM_ID_187                     SIM_ID_188
#> 188                   SIM_ID_188                     SIM_ID_189
#> 189                   SIM_ID_189                     SIM_ID_190
#> 190                   SIM_ID_190                     SIM_ID_191
#> 191                   SIM_ID_191                     SIM_ID_192
#> 192                   SIM_ID_192                     SIM_ID_193
#> 193                   SIM_ID_193                     SIM_ID_194
#> 194                   SIM_ID_194                     SIM_ID_195
#> 195                   SIM_ID_195                     SIM_ID_196
#> 196                   SIM_ID_196                     SIM_ID_197
#> 197                   SIM_ID_197                     SIM_ID_198
#> 198                   SIM_ID_198                     SIM_ID_199
#> 199                   SIM_ID_182                     SIM_ID_199
#> 200                     SIM_ID_1                     SIM_ID_200
#> 201                     SIM_ID_1                       SIM_ID_3
#> 202                     SIM_ID_1                     SIM_ID_199
#> 203                     SIM_ID_1                       SIM_ID_4
#> 204                     SIM_ID_1                     SIM_ID_198
#> 205                     SIM_ID_1                       SIM_ID_5
#> 206                     SIM_ID_1                     SIM_ID_197
#> 207                     SIM_ID_2                     SIM_ID_200
#> 208                     SIM_ID_2                       SIM_ID_4
#> 209                     SIM_ID_2                     SIM_ID_199
#> 210                     SIM_ID_2                       SIM_ID_5
#> 211                    SIM_ID_40                     SIM_ID_116
#> 212                     SIM_ID_2                       SIM_ID_6
#> 213                     SIM_ID_3                       SIM_ID_5
#> 214                     SIM_ID_3                     SIM_ID_200
#> 215                     SIM_ID_6                     SIM_ID_128
#> 216                     SIM_ID_3                     SIM_ID_199
#> 217                     SIM_ID_3                       SIM_ID_7
#> 218                     SIM_ID_4                       SIM_ID_6
#> 219                     SIM_ID_4                       SIM_ID_7
#> 220                   SIM_ID_114                     SIM_ID_200
#> 221                     SIM_ID_4                       SIM_ID_8
#> 222                     SIM_ID_5                       SIM_ID_7
#> 223                     SIM_ID_5                       SIM_ID_8
#> 224                     SIM_ID_5                       SIM_ID_9
#> 225                     SIM_ID_6                       SIM_ID_8
#> 226                     SIM_ID_6                       SIM_ID_9
#> 227                     SIM_ID_6                      SIM_ID_10
#> 228                     SIM_ID_7                       SIM_ID_9
#> 229                     SIM_ID_7                      SIM_ID_10
#> 230                     SIM_ID_7                     SIM_ID_145
#> 231                     SIM_ID_8                      SIM_ID_10
#> 232                     SIM_ID_8                      SIM_ID_11
#> 233                     SIM_ID_8                      SIM_ID_12
#> 234                     SIM_ID_9                      SIM_ID_11
#> 235                     SIM_ID_9                      SIM_ID_12
#> 236                     SIM_ID_9                      SIM_ID_13
#> 237                    SIM_ID_10                      SIM_ID_12
#> 238                    SIM_ID_13                     SIM_ID_170
#> 239                    SIM_ID_10                      SIM_ID_14
#> 240                    SIM_ID_11                      SIM_ID_13
#> 241                    SIM_ID_11                      SIM_ID_14
#> 242                    SIM_ID_11                      SIM_ID_15
#> 243                    SIM_ID_12                      SIM_ID_14
#> 244                    SIM_ID_12                      SIM_ID_15
#> 245                    SIM_ID_12                      SIM_ID_16
#> 246                    SIM_ID_13                      SIM_ID_15
#> 247                    SIM_ID_13                      SIM_ID_16
#> 248                    SIM_ID_13                      SIM_ID_17
#> 249                    SIM_ID_14                      SIM_ID_16
#> 250                    SIM_ID_14                      SIM_ID_17
#> 251                    SIM_ID_14                      SIM_ID_18
#> 252                    SIM_ID_15                      SIM_ID_17
#> 253                    SIM_ID_15                      SIM_ID_18
#> 254                    SIM_ID_15                      SIM_ID_19
#> 255                    SIM_ID_16                      SIM_ID_18
#> 256                    SIM_ID_16                      SIM_ID_19
#> 257                    SIM_ID_16                      SIM_ID_20
#> 258                    SIM_ID_17                      SIM_ID_19
#> 259                    SIM_ID_17                      SIM_ID_20
#> 260                    SIM_ID_17                      SIM_ID_21
#> 261                    SIM_ID_18                      SIM_ID_20
#> 262                    SIM_ID_18                      SIM_ID_21
#> 263                    SIM_ID_18                      SIM_ID_22
#> 264                    SIM_ID_19                      SIM_ID_21
#> 265                    SIM_ID_19                      SIM_ID_22
#> 266                    SIM_ID_19                      SIM_ID_23
#> 267                    SIM_ID_20                      SIM_ID_22
#> 268                    SIM_ID_20                      SIM_ID_23
#> 269                    SIM_ID_20                      SIM_ID_24
#> 270                    SIM_ID_21                      SIM_ID_23
#> 271                    SIM_ID_21                      SIM_ID_24
#> 272                    SIM_ID_21                      SIM_ID_25
#> 273                    SIM_ID_22                      SIM_ID_24
#> 274                    SIM_ID_25                     SIM_ID_169
#> 275                    SIM_ID_22                      SIM_ID_26
#> 276                    SIM_ID_23                      SIM_ID_25
#> 277                    SIM_ID_23                      SIM_ID_26
#> 278                    SIM_ID_23                      SIM_ID_27
#> 279                    SIM_ID_24                      SIM_ID_26
#> 280                    SIM_ID_24                      SIM_ID_27
#> 281                    SIM_ID_24                      SIM_ID_28
#> 282                    SIM_ID_25                      SIM_ID_27
#> 283                    SIM_ID_25                      SIM_ID_28
#> 284                    SIM_ID_25                      SIM_ID_29
#> 285                    SIM_ID_26                      SIM_ID_28
#> 286                    SIM_ID_26                      SIM_ID_29
#> 287                    SIM_ID_26                      SIM_ID_30
#> 288                    SIM_ID_29                     SIM_ID_185
#> 289                    SIM_ID_27                      SIM_ID_30
#> 290                    SIM_ID_27                      SIM_ID_31
#> 291                    SIM_ID_28                      SIM_ID_30
#> 292                    SIM_ID_28                      SIM_ID_31
#> 293                    SIM_ID_28                      SIM_ID_32
#> 294                    SIM_ID_29                      SIM_ID_31
#> 295                    SIM_ID_29                      SIM_ID_32
#> 296                    SIM_ID_29                      SIM_ID_33
#> 297                    SIM_ID_30                      SIM_ID_32
#> 298                    SIM_ID_30                      SIM_ID_33
#> 299                    SIM_ID_30                      SIM_ID_34
#> 300                    SIM_ID_31                      SIM_ID_33
#> 301                    SIM_ID_31                      SIM_ID_34
#> 302                    SIM_ID_31                      SIM_ID_35
#> 303                    SIM_ID_32                      SIM_ID_34
#> 304                    SIM_ID_32                     SIM_ID_146
#> 305                    SIM_ID_32                      SIM_ID_36
#> 306                    SIM_ID_35                      SIM_ID_49
#> 307                    SIM_ID_36                     SIM_ID_120
#> 308                    SIM_ID_33                      SIM_ID_37
#> 309                    SIM_ID_34                      SIM_ID_36
#> 310                    SIM_ID_34                      SIM_ID_37
#> 311                    SIM_ID_34                      SIM_ID_38
#> 312                    SIM_ID_35                      SIM_ID_37
#> 313                    SIM_ID_35                      SIM_ID_38
#> 314                    SIM_ID_35                      SIM_ID_39
#> 315                    SIM_ID_36                      SIM_ID_38
#> 316                    SIM_ID_36                      SIM_ID_39
#> 317                    SIM_ID_36                      SIM_ID_40
#> 318                    SIM_ID_37                     SIM_ID_125
#> 319                    SIM_ID_37                      SIM_ID_40
#> 320                    SIM_ID_37                      SIM_ID_41
#> 321                    SIM_ID_38                      SIM_ID_40
#> 322                    SIM_ID_38                      SIM_ID_41
#> 323                    SIM_ID_38                     SIM_ID_166
#> 324                    SIM_ID_39                      SIM_ID_41
#> 325                    SIM_ID_39                      SIM_ID_42
#> 326                    SIM_ID_39                      SIM_ID_43
#> 327                    SIM_ID_40                      SIM_ID_42
#> 328                    SIM_ID_40                      SIM_ID_43
#> 329                    SIM_ID_40                      SIM_ID_44
#> 330                    SIM_ID_41                      SIM_ID_43
#> 331                    SIM_ID_41                      SIM_ID_44
#> 332                    SIM_ID_41                      SIM_ID_45
#> 333                    SIM_ID_42                     SIM_ID_104
#> 334                    SIM_ID_42                      SIM_ID_45
#> 335                    SIM_ID_42                      SIM_ID_46
#> 336                    SIM_ID_43                      SIM_ID_45
#> 337                    SIM_ID_43                      SIM_ID_46
#> 338                    SIM_ID_43                      SIM_ID_47
#> 339                    SIM_ID_44                      SIM_ID_46
#> 340                    SIM_ID_44                      SIM_ID_47
#> 341                    SIM_ID_44                      SIM_ID_48
#> 342                    SIM_ID_45                      SIM_ID_47
#> 343                    SIM_ID_45                      SIM_ID_48
#> 344                    SIM_ID_45                      SIM_ID_49
#> 345                    SIM_ID_46                      SIM_ID_48
#> 346                    SIM_ID_46                      SIM_ID_49
#> 347                    SIM_ID_46                      SIM_ID_50
#> 348                    SIM_ID_47                      SIM_ID_49
#> 349                    SIM_ID_47                      SIM_ID_50
#> 350                    SIM_ID_47                      SIM_ID_51
#> 351                    SIM_ID_48                      SIM_ID_50
#> 352                    SIM_ID_48                      SIM_ID_51
#> 353                    SIM_ID_48                      SIM_ID_52
#> 354                    SIM_ID_49                      SIM_ID_51
#> 355                    SIM_ID_52                     SIM_ID_127
#> 356                    SIM_ID_49                      SIM_ID_53
#> 357                    SIM_ID_50                      SIM_ID_52
#> 358                    SIM_ID_53                     SIM_ID_176
#> 359                    SIM_ID_50                      SIM_ID_54
#> 360                    SIM_ID_51                      SIM_ID_53
#> 361                    SIM_ID_51                      SIM_ID_54
#> 362                    SIM_ID_51                      SIM_ID_55
#> 363                    SIM_ID_52                     SIM_ID_156
#> 364                    SIM_ID_52                      SIM_ID_55
#> 365                    SIM_ID_52                      SIM_ID_56
#> 366                    SIM_ID_53                      SIM_ID_55
#> 367                    SIM_ID_53                      SIM_ID_56
#> 368                    SIM_ID_53                      SIM_ID_57
#> 369                    SIM_ID_54                     SIM_ID_141
#> 370                    SIM_ID_54                      SIM_ID_57
#> 371                    SIM_ID_54                      SIM_ID_58
#> 372                    SIM_ID_55                      SIM_ID_57
#> 373                    SIM_ID_58                     SIM_ID_154
#> 374                    SIM_ID_55                      SIM_ID_59
#> 375                    SIM_ID_58                      SIM_ID_66
#> 376                    SIM_ID_56                      SIM_ID_59
#> 377                    SIM_ID_56                      SIM_ID_60
#> 378                    SIM_ID_57                      SIM_ID_59
#> 379                    SIM_ID_57                      SIM_ID_60
#> 380                    SIM_ID_61                     SIM_ID_163
#> 381                    SIM_ID_58                      SIM_ID_60
#> 382                    SIM_ID_58                      SIM_ID_61
#> 383                    SIM_ID_58                      SIM_ID_62
#> 384                    SIM_ID_59                      SIM_ID_61
#> 385                    SIM_ID_59                      SIM_ID_62
#> 386                    SIM_ID_59                      SIM_ID_63
#> 387                    SIM_ID_60                      SIM_ID_62
#> 388                    SIM_ID_60                      SIM_ID_63
#> 389                    SIM_ID_60                      SIM_ID_64
#> 390                    SIM_ID_61                      SIM_ID_63
#> 391                    SIM_ID_61                      SIM_ID_64
#> 392                    SIM_ID_61                      SIM_ID_65
#> 393                    SIM_ID_62                      SIM_ID_64
#> 394                    SIM_ID_62                      SIM_ID_65
#> 395                    SIM_ID_62                      SIM_ID_66
#> 396                    SIM_ID_63                      SIM_ID_65
#> 397                    SIM_ID_63                      SIM_ID_66
#> 398                    SIM_ID_63                      SIM_ID_67
#> 399                    SIM_ID_64                      SIM_ID_66
#> 400                    SIM_ID_67                      SIM_ID_85
#> 401                    SIM_ID_64                      SIM_ID_68
#> 402                    SIM_ID_65                      SIM_ID_67
#> 403                    SIM_ID_65                      SIM_ID_68
#> 404                    SIM_ID_65                      SIM_ID_69
#> 405                    SIM_ID_66                      SIM_ID_68
#> 406                    SIM_ID_66                      SIM_ID_69
#> 407                    SIM_ID_66                      SIM_ID_70
#> 408                    SIM_ID_67                      SIM_ID_69
#> 409                    SIM_ID_67                      SIM_ID_70
#> 410                    SIM_ID_67                      SIM_ID_71
#> 411                    SIM_ID_68                      SIM_ID_70
#> 412                    SIM_ID_68                      SIM_ID_71
#> 413                    SIM_ID_68                      SIM_ID_72
#> 414                    SIM_ID_69                      SIM_ID_71
#> 415                    SIM_ID_69                     SIM_ID_195
#> 416                    SIM_ID_69                      SIM_ID_73
#> 417                    SIM_ID_70                      SIM_ID_72
#> 418                    SIM_ID_70                      SIM_ID_73
#> 419                    SIM_ID_70                      SIM_ID_74
#> 420                    SIM_ID_71                      SIM_ID_73
#> 421                    SIM_ID_71                      SIM_ID_74
#> 422                    SIM_ID_71                      SIM_ID_75
#> 423                    SIM_ID_72                      SIM_ID_74
#> 424                    SIM_ID_72                      SIM_ID_75
#> 425                    SIM_ID_72                      SIM_ID_76
#> 426                    SIM_ID_73                      SIM_ID_75
#> 427                    SIM_ID_73                      SIM_ID_76
#> 428                    SIM_ID_73                      SIM_ID_77
#> 429                    SIM_ID_74                      SIM_ID_76
#> 430                    SIM_ID_74                      SIM_ID_77
#> 431                    SIM_ID_74                      SIM_ID_78
#> 432                    SIM_ID_77                     SIM_ID_168
#> 433                    SIM_ID_75                      SIM_ID_78
#> 434                    SIM_ID_75                      SIM_ID_79
#> 435                    SIM_ID_76                      SIM_ID_78
#> 436                    SIM_ID_76                      SIM_ID_79
#> 437                    SIM_ID_76                      SIM_ID_80
#> 438                    SIM_ID_77                      SIM_ID_79
#> 439                    SIM_ID_77                      SIM_ID_80
#> 440                    SIM_ID_77                      SIM_ID_81
#> 441                    SIM_ID_78                      SIM_ID_80
#> 442                    SIM_ID_78                      SIM_ID_81
#> 443                    SIM_ID_78                      SIM_ID_82
#> 444                    SIM_ID_79                     SIM_ID_100
#> 445                    SIM_ID_79                      SIM_ID_82
#> 446                    SIM_ID_79                      SIM_ID_83
#> 447                    SIM_ID_82                     SIM_ID_143
#> 448                    SIM_ID_80                      SIM_ID_83
#> 449                    SIM_ID_80                      SIM_ID_84
#> 450                    SIM_ID_81                      SIM_ID_83
#> 451                    SIM_ID_81                      SIM_ID_84
#> 452                    SIM_ID_81                      SIM_ID_85
#> 453                    SIM_ID_82                      SIM_ID_84
#> 454                    SIM_ID_19                      SIM_ID_85
#> 455                    SIM_ID_82                      SIM_ID_86
#> 456                    SIM_ID_83                      SIM_ID_85
#> 457                    SIM_ID_83                      SIM_ID_86
#> 458                    SIM_ID_83                      SIM_ID_87
#> 459                    SIM_ID_84                      SIM_ID_86
#> 460                    SIM_ID_84                      SIM_ID_87
#> 461                    SIM_ID_84                      SIM_ID_88
#> 462                    SIM_ID_85                      SIM_ID_87
#> 463                    SIM_ID_85                      SIM_ID_88
#> 464                    SIM_ID_85                      SIM_ID_89
#> 465                    SIM_ID_86                      SIM_ID_88
#> 466                    SIM_ID_86                      SIM_ID_89
#> 467                    SIM_ID_86                      SIM_ID_90
#> 468                    SIM_ID_87                      SIM_ID_95
#> 469                    SIM_ID_87                      SIM_ID_90
#> 470                    SIM_ID_87                      SIM_ID_91
#> 471                    SIM_ID_88                      SIM_ID_90
#> 472                    SIM_ID_88                      SIM_ID_91
#> 473                    SIM_ID_88                      SIM_ID_92
#> 474                    SIM_ID_89                      SIM_ID_91
#> 475                    SIM_ID_89                      SIM_ID_92
#> 476                    SIM_ID_89                      SIM_ID_93
#> 477                    SIM_ID_90                     SIM_ID_121
#> 478                    SIM_ID_90                      SIM_ID_93
#> 479                    SIM_ID_90                      SIM_ID_94
#> 480                    SIM_ID_91                      SIM_ID_93
#> 481                    SIM_ID_25                      SIM_ID_94
#> 482                    SIM_ID_91                      SIM_ID_95
#> 483                    SIM_ID_92                      SIM_ID_94
#> 484                    SIM_ID_92                      SIM_ID_95
#> 485                    SIM_ID_92                      SIM_ID_96
#> 486                    SIM_ID_95                     SIM_ID_124
#> 487                    SIM_ID_93                      SIM_ID_96
#> 488                    SIM_ID_75                      SIM_ID_93
#> 489                    SIM_ID_94                      SIM_ID_96
#> 490                    SIM_ID_94                      SIM_ID_97
#> 491                    SIM_ID_94                      SIM_ID_98
#> 492                    SIM_ID_95                      SIM_ID_97
#> 493                    SIM_ID_95                      SIM_ID_98
#> 494                    SIM_ID_95                      SIM_ID_99
#> 495                    SIM_ID_96                      SIM_ID_98
#> 496                    SIM_ID_96                      SIM_ID_99
#> 497                    SIM_ID_96                     SIM_ID_100
#> 498                    SIM_ID_97                      SIM_ID_99
#> 499                    SIM_ID_97                     SIM_ID_100
#> 500                    SIM_ID_97                     SIM_ID_101
#> 501                    SIM_ID_98                     SIM_ID_100
#> 502                    SIM_ID_98                     SIM_ID_101
#> 503                    SIM_ID_98                     SIM_ID_102
#> 504                    SIM_ID_99                     SIM_ID_101
#> 505                    SIM_ID_99                     SIM_ID_102
#> 506                    SIM_ID_99                     SIM_ID_103
#> 507                   SIM_ID_102                     SIM_ID_181
#> 508                   SIM_ID_100                     SIM_ID_103
#> 509                   SIM_ID_100                     SIM_ID_104
#> 510                   SIM_ID_101                     SIM_ID_103
#> 511                   SIM_ID_101                     SIM_ID_104
#> 512                   SIM_ID_101                     SIM_ID_105
#> 513                   SIM_ID_102                     SIM_ID_104
#> 514                   SIM_ID_102                     SIM_ID_105
#> 515                     SIM_ID_3                     SIM_ID_106
#> 516                   SIM_ID_103                     SIM_ID_105
#> 517                   SIM_ID_103                     SIM_ID_106
#> 518                   SIM_ID_103                     SIM_ID_107
#> 519                   SIM_ID_104                     SIM_ID_106
#> 520                   SIM_ID_104                     SIM_ID_107
#> 521                   SIM_ID_104                     SIM_ID_108
#> 522                   SIM_ID_105                     SIM_ID_107
#> 523                   SIM_ID_105                     SIM_ID_108
#> 524                   SIM_ID_105                     SIM_ID_109
#> 525                   SIM_ID_106                     SIM_ID_108
#> 526                   SIM_ID_106                     SIM_ID_109
#> 527                   SIM_ID_106                     SIM_ID_110
#> 528                   SIM_ID_107                     SIM_ID_109
#> 529                   SIM_ID_107                     SIM_ID_110
#> 530                   SIM_ID_107                     SIM_ID_111
#> 531                   SIM_ID_108                     SIM_ID_110
#> 532                   SIM_ID_108                     SIM_ID_111
#> 533                   SIM_ID_108                     SIM_ID_112
#> 534                   SIM_ID_109                     SIM_ID_111
#> 535                   SIM_ID_109                     SIM_ID_112
#> 536                   SIM_ID_109                     SIM_ID_113
#> 537                   SIM_ID_110                     SIM_ID_112
#> 538                   SIM_ID_110                     SIM_ID_113
#> 539                   SIM_ID_110                     SIM_ID_114
#> 540                   SIM_ID_111                     SIM_ID_113
#> 541                   SIM_ID_111                     SIM_ID_114
#> 542                   SIM_ID_111                     SIM_ID_115
#> 543                   SIM_ID_112                     SIM_ID_114
#> 544                   SIM_ID_112                     SIM_ID_115
#> 545                   SIM_ID_112                     SIM_ID_116
#> 546                   SIM_ID_113                     SIM_ID_115
#> 547                   SIM_ID_113                     SIM_ID_116
#> 548                   SIM_ID_113                     SIM_ID_117
#> 549                   SIM_ID_114                     SIM_ID_116
#> 550                   SIM_ID_114                     SIM_ID_117
#> 551                   SIM_ID_114                     SIM_ID_118
#> 552                   SIM_ID_115                     SIM_ID_117
#> 553                   SIM_ID_115                     SIM_ID_118
#> 554                   SIM_ID_115                     SIM_ID_119
#> 555                   SIM_ID_116                     SIM_ID_118
#> 556                   SIM_ID_116                     SIM_ID_119
#> 557                   SIM_ID_116                     SIM_ID_120
#> 558                   SIM_ID_117                     SIM_ID_119
#> 559                   SIM_ID_117                     SIM_ID_120
#> 560                   SIM_ID_117                     SIM_ID_121
#> 561                   SIM_ID_118                     SIM_ID_120
#> 562                   SIM_ID_118                     SIM_ID_121
#> 563                   SIM_ID_118                     SIM_ID_122
#> 564                   SIM_ID_119                     SIM_ID_121
#> 565                   SIM_ID_119                     SIM_ID_122
#> 566                   SIM_ID_119                     SIM_ID_123
#> 567                   SIM_ID_120                     SIM_ID_122
#> 568                   SIM_ID_120                     SIM_ID_123
#> 569                   SIM_ID_120                     SIM_ID_124
#> 570                   SIM_ID_121                     SIM_ID_123
#> 571                   SIM_ID_121                     SIM_ID_124
#> 572                   SIM_ID_121                     SIM_ID_125
#> 573                   SIM_ID_122                     SIM_ID_124
#> 574                   SIM_ID_122                     SIM_ID_125
#> 575                   SIM_ID_122                     SIM_ID_126
#> 576                   SIM_ID_123                     SIM_ID_125
#> 577                   SIM_ID_123                     SIM_ID_126
#> 578                   SIM_ID_123                     SIM_ID_127
#> 579                   SIM_ID_124                     SIM_ID_126
#> 580                   SIM_ID_124                     SIM_ID_127
#> 581                   SIM_ID_124                     SIM_ID_128
#> 582                   SIM_ID_125                     SIM_ID_127
#> 583                   SIM_ID_125                     SIM_ID_128
#> 584                   SIM_ID_125                     SIM_ID_129
#> 585                   SIM_ID_126                     SIM_ID_128
#> 586                   SIM_ID_126                     SIM_ID_129
#> 587                   SIM_ID_126                     SIM_ID_130
#> 588                   SIM_ID_127                     SIM_ID_129
#> 589                   SIM_ID_127                     SIM_ID_130
#> 590                   SIM_ID_127                     SIM_ID_131
#> 591                   SIM_ID_128                     SIM_ID_130
#> 592                   SIM_ID_128                     SIM_ID_131
#> 593                   SIM_ID_128                     SIM_ID_132
#> 594                   SIM_ID_129                     SIM_ID_131
#> 595                   SIM_ID_129                     SIM_ID_132
#> 596                   SIM_ID_129                     SIM_ID_133
#> 597                   SIM_ID_130                     SIM_ID_132
#> 598                   SIM_ID_130                     SIM_ID_133
#> 599                   SIM_ID_130                     SIM_ID_134
#> 600                   SIM_ID_131                     SIM_ID_133
#> 601                   SIM_ID_131                     SIM_ID_134
#> 602                   SIM_ID_131                     SIM_ID_135
#> 603                   SIM_ID_132                     SIM_ID_134
#> 604                   SIM_ID_132                     SIM_ID_135
#> 605                   SIM_ID_132                     SIM_ID_136
#> 606                   SIM_ID_133                     SIM_ID_135
#> 607                   SIM_ID_133                     SIM_ID_136
#> 608                   SIM_ID_133                     SIM_ID_137
#> 609                   SIM_ID_134                     SIM_ID_136
#> 610                   SIM_ID_134                     SIM_ID_137
#> 611                    SIM_ID_21                     SIM_ID_138
#> 612                   SIM_ID_135                     SIM_ID_137
#> 613                   SIM_ID_135                     SIM_ID_138
#> 614                   SIM_ID_135                     SIM_ID_139
#> 615                   SIM_ID_136                     SIM_ID_138
#> 616                   SIM_ID_136                     SIM_ID_139
#> 617                   SIM_ID_136                     SIM_ID_140
#> 618                    SIM_ID_98                     SIM_ID_137
#> 619                   SIM_ID_137                     SIM_ID_140
#> 620                   SIM_ID_137                     SIM_ID_141
#> 621                   SIM_ID_138                     SIM_ID_140
#> 622                   SIM_ID_138                     SIM_ID_141
#> 623                   SIM_ID_138                     SIM_ID_142
#> 624                   SIM_ID_139                     SIM_ID_141
#> 625                   SIM_ID_139                     SIM_ID_142
#> 626                   SIM_ID_139                     SIM_ID_143
#> 627                    SIM_ID_71                     SIM_ID_142
#> 628                   SIM_ID_140                     SIM_ID_143
#> 629                   SIM_ID_140                     SIM_ID_144
#> 630                    SIM_ID_64                     SIM_ID_143
#> 631                    SIM_ID_49                     SIM_ID_141
#> 632                   SIM_ID_141                     SIM_ID_145
#> 633                    SIM_ID_12                     SIM_ID_144
#> 634                   SIM_ID_142                     SIM_ID_145
#> 635                   SIM_ID_142                     SIM_ID_146
#> 636                   SIM_ID_143                     SIM_ID_145
#> 637                   SIM_ID_110                     SIM_ID_146
#> 638                   SIM_ID_143                     SIM_ID_147
#> 639                   SIM_ID_144                     SIM_ID_146
#> 640                   SIM_ID_105                     SIM_ID_144
#> 641                   SIM_ID_144                     SIM_ID_148
#> 642                    SIM_ID_99                     SIM_ID_147
#> 643                   SIM_ID_145                     SIM_ID_148
#> 644                   SIM_ID_145                     SIM_ID_149
#> 645                   SIM_ID_146                     SIM_ID_148
#> 646                   SIM_ID_146                     SIM_ID_182
#> 647                    SIM_ID_12                     SIM_ID_150
#> 648                   SIM_ID_147                     SIM_ID_149
#> 649                   SIM_ID_147                     SIM_ID_150
#> 650                   SIM_ID_147                     SIM_ID_151
#> 651                   SIM_ID_148                     SIM_ID_150
#> 652                   SIM_ID_148                     SIM_ID_151
#> 653                   SIM_ID_148                     SIM_ID_152
#> 654                   SIM_ID_149                     SIM_ID_151
#> 655                    SIM_ID_42                     SIM_ID_149
#> 656                   SIM_ID_149                     SIM_ID_153
#> 657                   SIM_ID_150                     SIM_ID_152
#> 658                   SIM_ID_150                     SIM_ID_153
#> 659                   SIM_ID_150                     SIM_ID_154
#> 660                   SIM_ID_151                     SIM_ID_153
#> 661                   SIM_ID_151                     SIM_ID_154
#> 662                   SIM_ID_151                     SIM_ID_155
#> 663                   SIM_ID_152                     SIM_ID_154
#> 664                   SIM_ID_152                     SIM_ID_155
#> 665                   SIM_ID_152                     SIM_ID_156
#> 666                   SIM_ID_153                     SIM_ID_155
#> 667                   SIM_ID_153                     SIM_ID_156
#> 668                   SIM_ID_153                     SIM_ID_157
#> 669                   SIM_ID_154                     SIM_ID_156
#> 670                   SIM_ID_154                     SIM_ID_157
#> 671                   SIM_ID_154                     SIM_ID_158
#> 672                   SIM_ID_155                     SIM_ID_157
#> 673                   SIM_ID_155                     SIM_ID_158
#> 674                   SIM_ID_155                     SIM_ID_159
#> 675                   SIM_ID_156                     SIM_ID_158
#> 676                   SIM_ID_156                     SIM_ID_159
#> 677                   SIM_ID_156                     SIM_ID_160
#> 678                   SIM_ID_157                     SIM_ID_159
#> 679                    SIM_ID_50                     SIM_ID_157
#> 680                   SIM_ID_161                     SIM_ID_176
#> 681                   SIM_ID_158                     SIM_ID_160
#> 682                   SIM_ID_158                     SIM_ID_161
#> 683                   SIM_ID_158                     SIM_ID_162
#> 684                   SIM_ID_159                     SIM_ID_161
#> 685                   SIM_ID_159                     SIM_ID_162
#> 686                   SIM_ID_159                     SIM_ID_163
#> 687                    SIM_ID_21                     SIM_ID_160
#> 688                   SIM_ID_160                     SIM_ID_163
#> 689                    SIM_ID_54                     SIM_ID_164
#> 690                   SIM_ID_161                     SIM_ID_163
#> 691                   SIM_ID_161                     SIM_ID_164
#> 692                   SIM_ID_161                     SIM_ID_165
#> 693                   SIM_ID_162                     SIM_ID_164
#> 694                   SIM_ID_162                     SIM_ID_165
#> 695                   SIM_ID_162                     SIM_ID_166
#> 696                   SIM_ID_163                     SIM_ID_165
#> 697                   SIM_ID_163                     SIM_ID_166
#> 698                   SIM_ID_163                     SIM_ID_167
#> 699                   SIM_ID_164                     SIM_ID_166
#> 700                   SIM_ID_164                     SIM_ID_167
#> 701                   SIM_ID_164                     SIM_ID_168
#> 702                   SIM_ID_165                     SIM_ID_167
#> 703                   SIM_ID_165                     SIM_ID_168
#> 704                   SIM_ID_165                     SIM_ID_169
#> 705                   SIM_ID_166                     SIM_ID_168
#> 706                   SIM_ID_166                     SIM_ID_169
#> 707                   SIM_ID_166                     SIM_ID_170
#> 708                   SIM_ID_167                     SIM_ID_169
#> 709                    SIM_ID_53                     SIM_ID_167
#> 710                   SIM_ID_167                     SIM_ID_171
#> 711                   SIM_ID_168                     SIM_ID_170
#> 712                   SIM_ID_168                     SIM_ID_171
#> 713                   SIM_ID_168                     SIM_ID_172
#> 714                   SIM_ID_169                     SIM_ID_171
#> 715                   SIM_ID_169                     SIM_ID_172
#> 716                   SIM_ID_169                     SIM_ID_173
#> 717                   SIM_ID_170                     SIM_ID_172
#> 718                   SIM_ID_173                     SIM_ID_180
#> 719                   SIM_ID_170                     SIM_ID_174
#> 720                   SIM_ID_171                     SIM_ID_173
#> 721                   SIM_ID_171                     SIM_ID_174
#> 722                   SIM_ID_171                     SIM_ID_175
#> 723                   SIM_ID_172                     SIM_ID_174
#> 724                   SIM_ID_172                     SIM_ID_175
#> 725                   SIM_ID_172                     SIM_ID_176
#> 726                   SIM_ID_173                     SIM_ID_175
#> 727                    SIM_ID_88                     SIM_ID_177
#> 728                   SIM_ID_173                     SIM_ID_177
#> 729                   SIM_ID_174                     SIM_ID_176
#> 730                   SIM_ID_174                     SIM_ID_177
#> 731                   SIM_ID_174                     SIM_ID_178
#> 732                   SIM_ID_175                     SIM_ID_177
#> 733                   SIM_ID_175                     SIM_ID_178
#> 734                   SIM_ID_175                     SIM_ID_179
#> 735                   SIM_ID_176                     SIM_ID_178
#> 736                   SIM_ID_176                     SIM_ID_179
#> 737                   SIM_ID_176                     SIM_ID_180
#> 738                   SIM_ID_177                     SIM_ID_179
#> 739                   SIM_ID_177                     SIM_ID_180
#> 740                   SIM_ID_132                     SIM_ID_181
#> 741                   SIM_ID_178                     SIM_ID_180
#> 742                   SIM_ID_178                     SIM_ID_181
#> 743                   SIM_ID_178                     SIM_ID_182
#> 744                   SIM_ID_179                     SIM_ID_181
#> 745                   SIM_ID_179                     SIM_ID_182
#> 746                   SIM_ID_179                     SIM_ID_183
#> 747                   SIM_ID_180                     SIM_ID_182
#> 748                   SIM_ID_180                     SIM_ID_183
#> 749                   SIM_ID_180                     SIM_ID_184
#> 750                   SIM_ID_181                     SIM_ID_183
#> 751                   SIM_ID_181                     SIM_ID_184
#> 752                   SIM_ID_121                     SIM_ID_185
#> 753                   SIM_ID_182                     SIM_ID_184
#> 754                   SIM_ID_182                     SIM_ID_185
#> 755                   SIM_ID_182                     SIM_ID_186
#> 756                   SIM_ID_183                     SIM_ID_185
#> 757                    SIM_ID_16                     SIM_ID_183
#> 758                   SIM_ID_183                     SIM_ID_187
#> 759                   SIM_ID_184                     SIM_ID_186
#> 760                   SIM_ID_184                     SIM_ID_187
#> 761                   SIM_ID_184                     SIM_ID_188
#> 762                   SIM_ID_185                     SIM_ID_187
#> 763                   SIM_ID_185                     SIM_ID_188
#> 764                   SIM_ID_185                     SIM_ID_189
#> 765                   SIM_ID_186                     SIM_ID_188
#> 766                   SIM_ID_186                     SIM_ID_189
#> 767                   SIM_ID_186                     SIM_ID_190
#> 768                   SIM_ID_187                     SIM_ID_189
#> 769                   SIM_ID_187                     SIM_ID_190
#> 770                   SIM_ID_187                     SIM_ID_191
#> 771                   SIM_ID_188                     SIM_ID_190
#> 772                   SIM_ID_188                     SIM_ID_191
#> 773                   SIM_ID_188                     SIM_ID_192
#> 774                   SIM_ID_189                     SIM_ID_191
#> 775                   SIM_ID_189                     SIM_ID_192
#> 776                   SIM_ID_189                     SIM_ID_193
#> 777                   SIM_ID_190                     SIM_ID_192
#> 778                   SIM_ID_190                     SIM_ID_193
#> 779                   SIM_ID_190                     SIM_ID_194
#> 780                   SIM_ID_191                     SIM_ID_193
#> 781                   SIM_ID_191                     SIM_ID_194
#> 782                   SIM_ID_191                     SIM_ID_195
#> 783                   SIM_ID_192                     SIM_ID_194
#> 784                   SIM_ID_192                     SIM_ID_195
#> 785                   SIM_ID_192                     SIM_ID_196
#> 786                   SIM_ID_193                     SIM_ID_195
#> 787                   SIM_ID_193                     SIM_ID_196
#> 788                   SIM_ID_193                     SIM_ID_197
#> 789                   SIM_ID_194                     SIM_ID_196
#> 790                   SIM_ID_194                     SIM_ID_197
#> 791                   SIM_ID_194                     SIM_ID_198
#> 792                   SIM_ID_195                     SIM_ID_197
#> 793                    SIM_ID_77                     SIM_ID_195
#> 794                   SIM_ID_195                     SIM_ID_199
#> 795                   SIM_ID_196                     SIM_ID_198
#> 796                   SIM_ID_196                     SIM_ID_199
#> 797                   SIM_ID_194                     SIM_ID_200
#> 798                   SIM_ID_197                     SIM_ID_199
#> 799                   SIM_ID_197                     SIM_ID_200
#> 800                   SIM_ID_198                     SIM_ID_200
#>     PrimaryCollaborator_Organization SecondaryCollaborator_Organization
#> 1                              Org F                              Org F
#> 2                              Org F                              Org E
#> 3                              Org E                              Org D
#> 4                              Org D                              Org C
#> 5                              Org C                              Org B
#> 6                              Org B                              Org A
#> 7                              Org A                              Org D
#> 8                              Org D                              Org E
#> 9                              Org E                              Org C
#> 10                             Org F                              Org C
#> 11                             Org F                              Org B
#> 12                             Org B                              Org F
#> 13                             Org F                              Org A
#> 14                             Org A                              Org C
#> 15                             Org C                              Org D
#> 16                             Org D                              Org F
#> 17                             Org F                              Org B
#> 18                             Org B                              Org F
#> 19                             Org F                              Org C
#> 20                             Org C                              Org A
#> 21                             Org A                              Org F
#> 22                             Org F                              Org F
#> 23                             Org F                              Org B
#> 24                             Org B                              Org C
#> 25                             Org C                              Org F
#> 26                             Org F                              Org E
#> 27                             Org E                              Org A
#> 28                             Org A                              Org F
#> 29                             Org F                              Org B
#> 30                             Org B                              Org F
#> 31                             Org F                              Org D
#> 32                             Org D                              Org E
#> 33                             Org E                              Org F
#> 34                             Org A                              Org F
#> 35                             Org A                              Org B
#> 36                             Org B                              Org F
#> 37                             Org F                              Org F
#> 38                             Org F                              Org E
#> 39                             Org E                              Org C
#> 40                             Org C                              Org F
#> 41                             Org F                              Org A
#> 42                             Org F                              Org E
#> 43                             Org F                              Org D
#> 44                             Org D                              Org C
#> 45                             Org C                              Org F
#> 46                             Org F                              Org F
#> 47                             Org F                              Org B
#> 48                             Org B                              Org A
#> 49                             Org A                              Org C
#> 50                             Org C                              Org E
#> 51                             Org E                              Org D
#> 52                             Org D                              Org F
#> 53                             Org F                              Org B
#> 54                             Org B                              Org C
#> 55                             Org C                              Org E
#> 56                             Org A                              Org E
#> 57                             Org E                              Org F
#> 58                             Org F                              Org F
#> 59                             Org F                              Org B
#> 60                             Org B                              Org F
#> 61                             Org E                              Org F
#> 62                             Org F                              Org A
#> 63                             Org A                              Org D
#> 64                             Org D                              Org C
#> 65                             Org C                              Org B
#> 66                             Org B                              Org F
#> 67                             Org F                              Org D
#> 68                             Org D                              Org E
#> 69                             Org E                              Org A
#> 70                             Org A                              Org F
#> 71                             Org F                              Org B
#> 72                             Org B                              Org A
#> 73                             Org F                              Org F
#> 74                             Org F                              Org C
#> 75                             Org C                              Org D
#> 76                             Org D                              Org A
#> 77                             Org A                              Org B
#> 78                             Org B                              Org F
#> 79                             Org F                              Org C
#> 80                             Org C                              Org E
#> 81                             Org E                              Org F
#> 82                             Org F                              Org F
#> 83                             Org F                              Org A
#> 84                             Org A                              Org C
#> 85                             Org C                              Org F
#> 86                             Org F                              Org E
#> 87                             Org E                              Org D
#> 88                             Org D                              Org F
#> 89                             Org F                              Org B
#> 90                             Org B                              Org A
#> 91                             Org A                              Org D
#> 92                             Org D                              Org E
#> 93                             Org E                              Org F
#> 94                             Org F                              Org C
#> 95                             Org C                              Org A
#> 96                             Org B                              Org F
#> 97                             Org F                              Org A
#> 98                             Org A                              Org E
#> 99                             Org E                              Org C
#> 100                            Org C                              Org H
#> 101                            Org H                              Org B
#> 102                            Org B                              Org H
#> 103                            Org H                              Org D
#> 104                            Org D                              Org A
#> 105                            Org A                              Org G
#> 106                            Org G                              Org H
#> 107                            Org H                              Org B
#> 108                            Org B                              Org H
#> 109                            Org H                              Org C
#> 110                            Org C                              Org H
#> 111                            Org A                              Org H
#> 112                            Org A                              Org H
#> 113                            Org H                              Org B
#> 114                            Org B                              Org C
#> 115                            Org C                              Org D
#> 116                            Org D                              Org E
#> 117                            Org E                              Org G
#> 118                            Org G                              Org A
#> 119                            Org A                              Org B
#> 120                            Org B                              Org H
#> 121                            Org H                              Org G
#> 122                            Org G                              Org E
#> 123                            Org E                              Org D
#> 124                            Org D                              Org C
#> 125                            Org C                              Org A
#> 126                            Org A                              Org H
#> 127                            Org H                              Org D
#> 128                            Org D                              Org E
#> 129                            Org E                              Org C
#> 130                            Org C                              Org H
#> 131                            Org H                              Org B
#> 132                            Org B                              Org A
#> 133                            Org A                              Org G
#> 134                            Org G                              Org C
#> 135                            Org C                              Org D
#> 136                            Org D                              Org H
#> 137                            Org H                              Org B
#> 138                            Org B                              Org H
#> 139                            Org H                              Org A
#> 140                            Org A                              Org E
#> 141                            Org E                              Org G
#> 142                            Org G                              Org H
#> 143                            Org H                              Org B
#> 144                            Org B                              Org C
#> 145                            Org C                              Org G
#> 146                            Org G                              Org A
#> 147                            Org A                              Org D
#> 148                            Org D                              Org H
#> 149                            Org H                              Org B
#> 150                            Org B                              Org H
#> 151                            Org H                              Org D
#> 152                            Org D                              Org E
#> 153                            Org E                              Org A
#> 154                            Org A                              Org C
#> 155                            Org C                              Org B
#> 156                            Org B                              Org H
#> 157                            Org H                              Org G
#> 158                            Org G                              Org E
#> 159                            Org E                              Org C
#> 160                            Org C                              Org A
#> 161                            Org E                              Org A
#> 162                            Org B                              Org H
#> 163                            Org E                              Org D
#> 164                            Org D                              Org C
#> 165                            Org C                              Org G
#> 166                            Org G                              Org H
#> 167                            Org H                              Org A
#> 168                            Org A                              Org H
#> 169                            Org H                              Org C
#> 170                            Org A                              Org C
#> 171                            Org E                              Org D
#> 172                            Org E                              Org D
#> 173                            Org H                              Org B
#> 174                            Org E                              Org A
#> 175                            Org A                              Org D
#> 176                            Org E                              Org C
#> 177                            Org E                              Org G
#> 178                            Org G                              Org H
#> 179                            Org H                              Org B
#> 180                            Org B                              Org H
#> 181                            Org H                              Org A
#> 182                            Org A                              Org E
#> 183                            Org C                              Org E
#> 184                            Org D                              Org C
#> 185                            Org C                              Org B
#> 186                            Org B                              Org H
#> 187                            Org H                              Org D
#> 188                            Org D                              Org A
#> 189                            Org A                              Org C
#> 190                            Org C                              Org H
#> 191                            Org H                              Org B
#> 192                            Org B                              Org H
#> 193                            Org H                              Org G
#> 194                            Org G                              Org C
#> 195                            Org C                              Org A
#> 196                            Org A                              Org H
#> 197                            Org H                              Org B
#> 198                            Org B                              Org H
#> 199                            Org A                              Org H
#> 200                            Org F                              Org C
#> 201                            Org F                              Org E
#> 202                            Org F                              Org H
#> 203                            Org F                              Org D
#> 204                            Org F                              Org B
#> 205                            Org F                              Org C
#> 206                            Org F                              Org H
#> 207                            Org F                              Org C
#> 208                            Org F                              Org D
#> 209                            Org F                              Org H
#> 210                            Org F                              Org C
#> 211                            Org C                              Org D
#> 212                            Org F                              Org B
#> 213                            Org E                              Org C
#> 214                            Org E                              Org C
#> 215                            Org B                              Org D
#> 216                            Org E                              Org H
#> 217                            Org E                              Org A
#> 218                            Org D                              Org B
#> 219                            Org D                              Org A
#> 220                            Org B                              Org C
#> 221                            Org D                              Org D
#> 222                            Org C                              Org A
#> 223                            Org C                              Org D
#> 224                            Org C                              Org E
#> 225                            Org B                              Org D
#> 226                            Org B                              Org E
#> 227                            Org B                              Org C
#> 228                            Org A                              Org E
#> 229                            Org A                              Org C
#> 230                            Org A                              Org C
#> 231                            Org D                              Org C
#> 232                            Org D                              Org F
#> 233                            Org D                              Org B
#> 234                            Org E                              Org F
#> 235                            Org E                              Org B
#> 236                            Org E                              Org F
#> 237                            Org C                              Org B
#> 238                            Org F                              Org C
#> 239                            Org C                              Org A
#> 240                            Org F                              Org F
#> 241                            Org F                              Org A
#> 242                            Org F                              Org C
#> 243                            Org B                              Org A
#> 244                            Org B                              Org C
#> 245                            Org B                              Org D
#> 246                            Org F                              Org C
#> 247                            Org F                              Org D
#> 248                            Org F                              Org F
#> 249                            Org A                              Org D
#> 250                            Org A                              Org F
#> 251                            Org A                              Org B
#> 252                            Org C                              Org F
#> 253                            Org C                              Org B
#> 254                            Org C                              Org F
#> 255                            Org D                              Org B
#> 256                            Org D                              Org F
#> 257                            Org D                              Org C
#> 258                            Org F                              Org F
#> 259                            Org F                              Org C
#> 260                            Org F                              Org A
#> 261                            Org B                              Org C
#> 262                            Org B                              Org A
#> 263                            Org B                              Org F
#> 264                            Org F                              Org A
#> 265                            Org F                              Org F
#> 266                            Org F                              Org F
#> 267                            Org C                              Org F
#> 268                            Org C                              Org F
#> 269                            Org C                              Org B
#> 270                            Org A                              Org F
#> 271                            Org A                              Org B
#> 272                            Org A                              Org C
#> 273                            Org F                              Org B
#> 274                            Org C                              Org H
#> 275                            Org F                              Org F
#> 276                            Org F                              Org C
#> 277                            Org F                              Org F
#> 278                            Org F                              Org E
#> 279                            Org B                              Org F
#> 280                            Org B                              Org E
#> 281                            Org B                              Org A
#> 282                            Org C                              Org E
#> 283                            Org C                              Org A
#> 284                            Org C                              Org F
#> 285                            Org F                              Org A
#> 286                            Org F                              Org F
#> 287                            Org F                              Org B
#> 288                            Org F                              Org C
#> 289                            Org E                              Org B
#> 290                            Org E                              Org F
#> 291                            Org A                              Org B
#> 292                            Org A                              Org F
#> 293                            Org A                              Org D
#> 294                            Org F                              Org F
#> 295                            Org F                              Org D
#> 296                            Org F                              Org E
#> 297                            Org B                              Org D
#> 298                            Org B                              Org E
#> 299                            Org B                              Org F
#> 300                            Org F                              Org E
#> 301                            Org F                              Org F
#> 302                            Org F                              Org A
#> 303                            Org D                              Org F
#> 304                            Org D                              Org G
#> 305                            Org D                              Org B
#> 306                            Org A                              Org A
#> 307                            Org B                              Org B
#> 308                            Org E                              Org F
#> 309                            Org F                              Org B
#> 310                            Org F                              Org F
#> 311                            Org F                              Org F
#> 312                            Org A                              Org F
#> 313                            Org A                              Org F
#> 314                            Org A                              Org E
#> 315                            Org B                              Org F
#> 316                            Org B                              Org E
#> 317                            Org B                              Org C
#> 318                            Org F                              Org C
#> 319                            Org F                              Org C
#> 320                            Org F                              Org F
#> 321                            Org F                              Org C
#> 322                            Org F                              Org F
#> 323                            Org F                              Org G
#> 324                            Org E                              Org F
#> 325                            Org E                              Org A
#> 326                            Org E                              Org F
#> 327                            Org C                              Org A
#> 328                            Org C                              Org F
#> 329                            Org C                              Org D
#> 330                            Org F                              Org F
#> 331                            Org F                              Org D
#> 332                            Org F                              Org C
#> 333                            Org A                              Org D
#> 334                            Org A                              Org C
#> 335                            Org A                              Org F
#> 336                            Org F                              Org C
#> 337                            Org F                              Org F
#> 338                            Org F                              Org F
#> 339                            Org D                              Org F
#> 340                            Org D                              Org F
#> 341                            Org D                              Org B
#> 342                            Org C                              Org F
#> 343                            Org C                              Org B
#> 344                            Org C                              Org A
#> 345                            Org F                              Org B
#> 346                            Org F                              Org A
#> 347                            Org F                              Org C
#> 348                            Org F                              Org A
#> 349                            Org F                              Org C
#> 350                            Org F                              Org E
#> 351                            Org B                              Org C
#> 352                            Org B                              Org E
#> 353                            Org B                              Org D
#> 354                            Org A                              Org E
#> 355                            Org D                              Org H
#> 356                            Org A                              Org F
#> 357                            Org C                              Org D
#> 358                            Org F                              Org D
#> 359                            Org C                              Org B
#> 360                            Org E                              Org F
#> 361                            Org E                              Org B
#> 362                            Org E                              Org C
#> 363                            Org D                              Org B
#> 364                            Org D                              Org C
#> 365                            Org D                              Org A
#> 366                            Org F                              Org C
#> 367                            Org F                              Org A
#> 368                            Org F                              Org E
#> 369                            Org B                              Org E
#> 370                            Org B                              Org E
#> 371                            Org B                              Org F
#> 372                            Org C                              Org E
#> 373                            Org F                              Org A
#> 374                            Org C                              Org F
#> 375                            Org F                              Org B
#> 376                            Org A                              Org F
#> 377                            Org A                              Org B
#> 378                            Org E                              Org F
#> 379                            Org E                              Org B
#> 380                            Org F                              Org H
#> 381                            Org F                              Org B
#> 382                            Org F                              Org F
#> 383                            Org F                              Org F
#> 384                            Org F                              Org F
#> 385                            Org F                              Org F
#> 386                            Org F                              Org A
#> 387                            Org B                              Org F
#> 388                            Org B                              Org A
#> 389                            Org B                              Org D
#> 390                            Org F                              Org A
#> 391                            Org F                              Org D
#> 392                            Org F                              Org C
#> 393                            Org F                              Org D
#> 394                            Org F                              Org C
#> 395                            Org F                              Org B
#> 396                            Org A                              Org C
#> 397                            Org A                              Org B
#> 398                            Org A                              Org F
#> 399                            Org D                              Org B
#> 400                            Org F                              Org C
#> 401                            Org D                              Org D
#> 402                            Org C                              Org F
#> 403                            Org C                              Org D
#> 404                            Org C                              Org E
#> 405                            Org B                              Org D
#> 406                            Org B                              Org E
#> 407                            Org B                              Org A
#> 408                            Org F                              Org E
#> 409                            Org F                              Org A
#> 410                            Org F                              Org F
#> 411                            Org D                              Org A
#> 412                            Org D                              Org F
#> 413                            Org D                              Org B
#> 414                            Org E                              Org F
#> 415                            Org E                              Org C
#> 416                            Org E                              Org F
#> 417                            Org A                              Org B
#> 418                            Org A                              Org F
#> 419                            Org A                              Org F
#> 420                            Org F                              Org F
#> 421                            Org F                              Org F
#> 422                            Org F                              Org C
#> 423                            Org B                              Org F
#> 424                            Org B                              Org C
#> 425                            Org B                              Org D
#> 426                            Org F                              Org C
#> 427                            Org F                              Org D
#> 428                            Org F                              Org A
#> 429                            Org F                              Org D
#> 430                            Org F                              Org A
#> 431                            Org F                              Org B
#> 432                            Org A                              Org A
#> 433                            Org C                              Org B
#> 434                            Org C                              Org F
#> 435                            Org D                              Org B
#> 436                            Org D                              Org F
#> 437                            Org D                              Org C
#> 438                            Org A                              Org F
#> 439                            Org A                              Org C
#> 440                            Org A                              Org E
#> 441                            Org B                              Org C
#> 442                            Org B                              Org E
#> 443                            Org B                              Org F
#> 444                            Org F                              Org C
#> 445                            Org F                              Org F
#> 446                            Org F                              Org F
#> 447                            Org F                              Org H
#> 448                            Org C                              Org F
#> 449                            Org C                              Org A
#> 450                            Org E                              Org F
#> 451                            Org E                              Org A
#> 452                            Org E                              Org C
#> 453                            Org F                              Org A
#> 454                            Org F                              Org C
#> 455                            Org F                              Org F
#> 456                            Org F                              Org C
#> 457                            Org F                              Org F
#> 458                            Org F                              Org E
#> 459                            Org A                              Org F
#> 460                            Org A                              Org E
#> 461                            Org A                              Org D
#> 462                            Org C                              Org E
#> 463                            Org C                              Org D
#> 464                            Org C                              Org F
#> 465                            Org F                              Org D
#> 466                            Org F                              Org F
#> 467                            Org F                              Org B
#> 468                            Org E                              Org C
#> 469                            Org E                              Org B
#> 470                            Org E                              Org A
#> 471                            Org D                              Org B
#> 472                            Org D                              Org A
#> 473                            Org D                              Org D
#> 474                            Org F                              Org A
#> 475                            Org F                              Org D
#> 476                            Org F                              Org E
#> 477                            Org B                              Org H
#> 478                            Org B                              Org E
#> 479                            Org B                              Org F
#> 480                            Org A                              Org E
#> 481                            Org C                              Org F
#> 482                            Org A                              Org C
#> 483                            Org D                              Org F
#> 484                            Org D                              Org C
#> 485                            Org D                              Org B
#> 486                            Org C                              Org D
#> 487                            Org E                              Org B
#> 488                            Org C                              Org E
#> 489                            Org F                              Org B
#> 490                            Org F                              Org F
#> 491                            Org F                              Org A
#> 492                            Org C                              Org F
#> 493                            Org C                              Org A
#> 494                            Org C                              Org E
#> 495                            Org B                              Org A
#> 496                            Org B                              Org E
#> 497                            Org B                              Org C
#> 498                            Org F                              Org E
#> 499                            Org F                              Org C
#> 500                            Org F                              Org H
#> 501                            Org A                              Org C
#> 502                            Org A                              Org H
#> 503                            Org A                              Org B
#> 504                            Org E                              Org H
#> 505                            Org E                              Org B
#> 506                            Org E                              Org H
#> 507                            Org B                              Org H
#> 508                            Org C                              Org H
#> 509                            Org C                              Org D
#> 510                            Org H                              Org H
#> 511                            Org H                              Org D
#> 512                            Org H                              Org A
#> 513                            Org B                              Org D
#> 514                            Org B                              Org A
#> 515                            Org E                              Org G
#> 516                            Org H                              Org A
#> 517                            Org H                              Org G
#> 518                            Org H                              Org H
#> 519                            Org D                              Org G
#> 520                            Org D                              Org H
#> 521                            Org D                              Org B
#> 522                            Org A                              Org H
#> 523                            Org A                              Org B
#> 524                            Org A                              Org H
#> 525                            Org G                              Org B
#> 526                            Org G                              Org H
#> 527                            Org G                              Org C
#> 528                            Org H                              Org H
#> 529                            Org H                              Org C
#> 530                            Org H                              Org E
#> 531                            Org B                              Org C
#> 532                            Org B                              Org E
#> 533                            Org B                              Org A
#> 534                            Org H                              Org E
#> 535                            Org H                              Org A
#> 536                            Org H                              Org H
#> 537                            Org C                              Org A
#> 538                            Org C                              Org H
#> 539                            Org C                              Org B
#> 540                            Org E                              Org H
#> 541                            Org E                              Org B
#> 542                            Org E                              Org C
#> 543                            Org A                              Org B
#> 544                            Org A                              Org C
#> 545                            Org A                              Org D
#> 546                            Org H                              Org C
#> 547                            Org H                              Org D
#> 548                            Org H                              Org E
#> 549                            Org B                              Org D
#> 550                            Org B                              Org E
#> 551                            Org B                              Org G
#> 552                            Org C                              Org E
#> 553                            Org C                              Org G
#> 554                            Org C                              Org A
#> 555                            Org D                              Org G
#> 556                            Org D                              Org A
#> 557                            Org D                              Org B
#> 558                            Org E                              Org A
#> 559                            Org E                              Org B
#> 560                            Org E                              Org H
#> 561                            Org G                              Org B
#> 562                            Org G                              Org H
#> 563                            Org G                              Org G
#> 564                            Org A                              Org H
#> 565                            Org A                              Org G
#> 566                            Org A                              Org E
#> 567                            Org B                              Org G
#> 568                            Org B                              Org E
#> 569                            Org B                              Org D
#> 570                            Org H                              Org E
#> 571                            Org H                              Org D
#> 572                            Org H                              Org C
#> 573                            Org G                              Org D
#> 574                            Org G                              Org C
#> 575                            Org G                              Org A
#> 576                            Org E                              Org C
#> 577                            Org E                              Org A
#> 578                            Org E                              Org H
#> 579                            Org D                              Org A
#> 580                            Org D                              Org H
#> 581                            Org D                              Org D
#> 582                            Org C                              Org H
#> 583                            Org C                              Org D
#> 584                            Org C                              Org E
#> 585                            Org A                              Org D
#> 586                            Org A                              Org E
#> 587                            Org A                              Org C
#> 588                            Org H                              Org E
#> 589                            Org H                              Org C
#> 590                            Org H                              Org H
#> 591                            Org D                              Org C
#> 592                            Org D                              Org H
#> 593                            Org D                              Org B
#> 594                            Org E                              Org H
#> 595                            Org E                              Org B
#> 596                            Org E                              Org A
#> 597                            Org C                              Org B
#> 598                            Org C                              Org A
#> 599                            Org C                              Org G
#> 600                            Org H                              Org A
#> 601                            Org H                              Org G
#> 602                            Org H                              Org C
#> 603                            Org B                              Org G
#> 604                            Org B                              Org C
#> 605                            Org B                              Org D
#> 606                            Org A                              Org C
#> 607                            Org A                              Org D
#> 608                            Org A                              Org H
#> 609                            Org G                              Org D
#> 610                            Org G                              Org H
#> 611                            Org A                              Org B
#> 612                            Org C                              Org H
#> 613                            Org C                              Org B
#> 614                            Org C                              Org H
#> 615                            Org D                              Org B
#> 616                            Org D                              Org H
#> 617                            Org D                              Org A
#> 618                            Org A                              Org H
#> 619                            Org H                              Org A
#> 620                            Org H                              Org E
#> 621                            Org B                              Org A
#> 622                            Org B                              Org E
#> 623                            Org B                              Org G
#> 624                            Org H                              Org E
#> 625                            Org H                              Org G
#> 626                            Org H                              Org H
#> 627                            Org F                              Org G
#> 628                            Org A                              Org H
#> 629                            Org A                              Org B
#> 630                            Org D                              Org H
#> 631                            Org A                              Org E
#> 632                            Org E                              Org C
#> 633                            Org B                              Org B
#> 634                            Org G                              Org C
#> 635                            Org G                              Org G
#> 636                            Org H                              Org C
#> 637                            Org C                              Org G
#> 638                            Org H                              Org A
#> 639                            Org B                              Org G
#> 640                            Org A                              Org B
#> 641                            Org B                              Org D
#> 642                            Org E                              Org A
#> 643                            Org C                              Org D
#> 644                            Org C                              Org H
#> 645                            Org G                              Org D
#> 646                            Org G                              Org A
#> 647                            Org B                              Org B
#> 648                            Org A                              Org H
#> 649                            Org A                              Org B
#> 650                            Org A                              Org H
#> 651                            Org D                              Org B
#> 652                            Org D                              Org H
#> 653                            Org D                              Org D
#> 654                            Org H                              Org H
#> 655                            Org A                              Org H
#> 656                            Org H                              Org E
#> 657                            Org B                              Org D
#> 658                            Org B                              Org E
#> 659                            Org B                              Org A
#> 660                            Org H                              Org E
#> 661                            Org H                              Org A
#> 662                            Org H                              Org C
#> 663                            Org D                              Org A
#> 664                            Org D                              Org C
#> 665                            Org D                              Org B
#> 666                            Org E                              Org C
#> 667                            Org E                              Org B
#> 668                            Org E                              Org H
#> 669                            Org A                              Org B
#> 670                            Org A                              Org H
#> 671                            Org A                              Org G
#> 672                            Org C                              Org H
#> 673                            Org C                              Org G
#> 674                            Org C                              Org E
#> 675                            Org B                              Org G
#> 676                            Org B                              Org E
#> 677                            Org B                              Org C
#> 678                            Org H                              Org E
#> 679                            Org C                              Org H
#> 680                            Org A                              Org D
#> 681                            Org G                              Org C
#> 682                            Org G                              Org A
#> 683                            Org G                              Org B
#> 684                            Org E                              Org A
#> 685                            Org E                              Org B
#> 686                            Org E                              Org H
#> 687                            Org A                              Org C
#> 688                            Org C                              Org H
#> 689                            Org B                              Org D
#> 690                            Org A                              Org H
#> 691                            Org A                              Org D
#> 692                            Org A                              Org C
#> 693                            Org B                              Org D
#> 694                            Org B                              Org C
#> 695                            Org B                              Org G
#> 696                            Org H                              Org C
#> 697                            Org H                              Org G
#> 698                            Org H                              Org H
#> 699                            Org D                              Org G
#> 700                            Org D                              Org H
#> 701                            Org D                              Org A
#> 702                            Org C                              Org H
#> 703                            Org C                              Org A
#> 704                            Org C                              Org H
#> 705                            Org G                              Org A
#> 706                            Org G                              Org H
#> 707                            Org G                              Org C
#> 708                            Org H                              Org H
#> 709                            Org F                              Org H
#> 710                            Org H                              Org E
#> 711                            Org A                              Org C
#> 712                            Org A                              Org E
#> 713                            Org A                              Org D
#> 714                            Org H                              Org E
#> 715                            Org H                              Org D
#> 716                            Org H                              Org H
#> 717                            Org C                              Org D
#> 718                            Org H                              Org B
#> 719                            Org C                              Org B
#> 720                            Org E                              Org H
#> 721                            Org E                              Org B
#> 722                            Org E                              Org A
#> 723                            Org D                              Org B
#> 724                            Org D                              Org A
#> 725                            Org D                              Org D
#> 726                            Org H                              Org A
#> 727                            Org D                              Org E
#> 728                            Org H                              Org E
#> 729                            Org B                              Org D
#> 730                            Org B                              Org E
#> 731                            Org B                              Org G
#> 732                            Org A                              Org E
#> 733                            Org A                              Org G
#> 734                            Org A                              Org H
#> 735                            Org D                              Org G
#> 736                            Org D                              Org H
#> 737                            Org D                              Org B
#> 738                            Org E                              Org H
#> 739                            Org E                              Org B
#> 740                            Org B                              Org H
#> 741                            Org G                              Org B
#> 742                            Org G                              Org H
#> 743                            Org G                              Org A
#> 744                            Org H                              Org H
#> 745                            Org H                              Org A
#> 746                            Org H                              Org E
#> 747                            Org B                              Org A
#> 748                            Org B                              Org E
#> 749                            Org B                              Org D
#> 750                            Org H                              Org E
#> 751                            Org H                              Org D
#> 752                            Org H                              Org C
#> 753                            Org A                              Org D
#> 754                            Org A                              Org C
#> 755                            Org A                              Org B
#> 756                            Org E                              Org C
#> 757                            Org D                              Org E
#> 758                            Org E                              Org H
#> 759                            Org D                              Org B
#> 760                            Org D                              Org H
#> 761                            Org D                              Org D
#> 762                            Org C                              Org H
#> 763                            Org C                              Org D
#> 764                            Org C                              Org A
#> 765                            Org B                              Org D
#> 766                            Org B                              Org A
#> 767                            Org B                              Org C
#> 768                            Org H                              Org A
#> 769                            Org H                              Org C
#> 770                            Org H                              Org H
#> 771                            Org D                              Org C
#> 772                            Org D                              Org H
#> 773                            Org D                              Org B
#> 774                            Org A                              Org H
#> 775                            Org A                              Org B
#> 776                            Org A                              Org H
#> 777                            Org C                              Org B
#> 778                            Org C                              Org H
#> 779                            Org C                              Org G
#> 780                            Org H                              Org H
#> 781                            Org H                              Org G
#> 782                            Org H                              Org C
#> 783                            Org B                              Org G
#> 784                            Org B                              Org C
#> 785                            Org B                              Org A
#> 786                            Org H                              Org C
#> 787                            Org H                              Org A
#> 788                            Org H                              Org H
#> 789                            Org G                              Org A
#> 790                            Org G                              Org H
#> 791                            Org G                              Org B
#> 792                            Org C                              Org H
#> 793                            Org A                              Org C
#> 794                            Org C                              Org H
#> 795                            Org A                              Org B
#> 796                            Org A                              Org H
#> 797                            Org G                              Org C
#> 798                            Org H                              Org H
#> 799                            Org H                              Org C
#> 800                            Org B                              Org C
#>     PrimaryCollaborator_LevelDesignation SecondaryCollaborator_LevelDesignation
#> 1                                Level 1                                Level 2
#> 2                                Level 2                                Level 3
#> 3                                Level 3                                Level 4
#> 4                                Level 4                                Level 5
#> 5                                Level 5                                Level 6
#> 6                                Level 6                                Level 7
#> 7                                Level 7                                Level 8
#> 8                                Level 8                                Level 9
#> 9                                Level 9                                Level 1
#> 10                               Level 1                                Level 5
#> 11                               Level 1                                Level 1
#> 12                               Level 1                                Level 1
#> 13                               Level 1                                Level 1
#> 14                               Level 1                                Level 1
#> 15                               Level 1                                Level 1
#> 16                               Level 1                                Level 1
#> 17                               Level 1                                Level 1
#> 18                               Level 1                                Level 1
#> 19                               Level 1                                Level 2
#> 20                               Level 2                                Level 2
#> 21                               Level 2                                Level 2
#> 22                               Level 2                                Level 2
#> 23                               Level 2                                Level 2
#> 24                               Level 2                                Level 2
#> 25                               Level 2                                Level 2
#> 26                               Level 2                                Level 2
#> 27                               Level 2                                Level 2
#> 28                               Level 2                                Level 2
#> 29                               Level 2                                Level 3
#> 30                               Level 3                                Level 3
#> 31                               Level 3                                Level 3
#> 32                               Level 3                                Level 3
#> 33                               Level 3                                Level 3
#> 34                               Level 3                                Level 8
#> 35                               Level 3                                Level 3
#> 36                               Level 3                                Level 3
#> 37                               Level 3                                Level 3
#> 38                               Level 3                                Level 3
#> 39                               Level 3                                Level 4
#> 40                               Level 4                                Level 4
#> 41                               Level 4                                Level 4
#> 42                               Level 4                                Level 1
#> 43                               Level 4                                Level 4
#> 44                               Level 4                                Level 4
#> 45                               Level 4                                Level 4
#> 46                               Level 4                                Level 4
#> 47                               Level 4                                Level 4
#> 48                               Level 4                                Level 4
#> 49                               Level 4                                Level 5
#> 50                               Level 5                                Level 5
#> 51                               Level 5                                Level 5
#> 52                               Level 5                                Level 5
#> 53                               Level 5                                Level 5
#> 54                               Level 5                                Level 5
#> 55                               Level 5                                Level 1
#> 56                               Level 5                                Level 5
#> 57                               Level 5                                Level 5
#> 58                               Level 5                                Level 5
#> 59                               Level 5                                Level 6
#> 60                               Level 6                                Level 6
#> 61                               Level 5                                Level 6
#> 62                               Level 6                                Level 6
#> 63                               Level 6                                Level 6
#> 64                               Level 6                                Level 6
#> 65                               Level 6                                Level 6
#> 66                               Level 6                                Level 6
#> 67                               Level 6                                Level 6
#> 68                               Level 6                                Level 6
#> 69                               Level 6                                Level 7
#> 70                               Level 7                                Level 7
#> 71                               Level 7                                Level 7
#> 72                               Level 7                                Level 9
#> 73                               Level 7                                Level 7
#> 74                               Level 7                                Level 7
#> 75                               Level 7                                Level 7
#> 76                               Level 7                                Level 7
#> 77                               Level 7                                Level 7
#> 78                               Level 7                                Level 7
#> 79                               Level 7                                Level 8
#> 80                               Level 8                                Level 8
#> 81                               Level 8                                Level 8
#> 82                               Level 8                                Level 8
#> 83                               Level 8                                Level 8
#> 84                               Level 8                                Level 8
#> 85                               Level 8                                Level 8
#> 86                               Level 8                                Level 8
#> 87                               Level 8                                Level 8
#> 88                               Level 8                                Level 8
#> 89                               Level 8                                Level 9
#> 90                               Level 9                                Level 9
#> 91                               Level 9                                Level 9
#> 92                               Level 9                                Level 9
#> 93                               Level 9                                Level 9
#> 94                               Level 4                                Level 9
#> 95                               Level 9                                Level 1
#> 96                               Level 9                                Level 9
#> 97                               Level 9                                Level 9
#> 98                               Level 9                                Level 9
#> 99                               Level 3                                Level 1
#> 100                              Level 1                                Level 1
#> 101                              Level 1                                Level 1
#> 102                              Level 1                                Level 1
#> 103                              Level 1                                Level 1
#> 104                              Level 1                                Level 1
#> 105                              Level 1                                Level 1
#> 106                              Level 1                                Level 1
#> 107                              Level 1                                Level 1
#> 108                              Level 1                                Level 1
#> 109                              Level 1                                Level 1
#> 110                              Level 1                                Level 1
#> 111                              Level 1                                Level 1
#> 112                              Level 1                                Level 1
#> 113                              Level 1                                Level 1
#> 114                              Level 1                                Level 1
#> 115                              Level 1                                Level 1
#> 116                              Level 1                                Level 1
#> 117                              Level 1                                Level 1
#> 118                              Level 1                                Level 1
#> 119                              Level 1                                Level 1
#> 120                              Level 1                                Level 1
#> 121                              Level 1                                Level 1
#> 122                              Level 1                                Level 1
#> 123                              Level 1                                Level 1
#> 124                              Level 1                                Level 1
#> 125                              Level 1                                Level 1
#> 126                              Level 1                                Level 1
#> 127                              Level 1                                Level 1
#> 128                              Level 1                                Level 1
#> 129                              Level 1                                Level 1
#> 130                              Level 1                                Level 1
#> 131                              Level 1                                Level 1
#> 132                              Level 1                                Level 1
#> 133                              Level 1                                Level 1
#> 134                              Level 1                                Level 1
#> 135                              Level 1                                Level 1
#> 136                              Level 1                                Level 1
#> 137                              Level 1                                Level 1
#> 138                              Level 1                                Level 1
#> 139                              Level 1                                Level 1
#> 140                              Level 1                                Level 1
#> 141                              Level 1                                Level 1
#> 142                              Level 1                                Level 1
#> 143                              Level 1                                Level 1
#> 144                              Level 1                                Level 1
#> 145                              Level 1                                Level 1
#> 146                              Level 1                                Level 1
#> 147                              Level 1                                Level 1
#> 148                              Level 1                                Level 1
#> 149                              Level 1                                Level 1
#> 150                              Level 1                                Level 1
#> 151                              Level 1                                Level 1
#> 152                              Level 1                                Level 1
#> 153                              Level 1                                Level 1
#> 154                              Level 1                                Level 1
#> 155                              Level 1                                Level 1
#> 156                              Level 1                                Level 1
#> 157                              Level 1                                Level 1
#> 158                              Level 1                                Level 1
#> 159                              Level 1                                Level 1
#> 160                              Level 1                                Level 1
#> 161                              Level 6                                Level 1
#> 162                              Level 1                                Level 1
#> 163                              Level 3                                Level 1
#> 164                              Level 1                                Level 1
#> 165                              Level 1                                Level 1
#> 166                              Level 1                                Level 1
#> 167                              Level 1                                Level 1
#> 168                              Level 1                                Level 1
#> 169                              Level 1                                Level 1
#> 170                              Level 9                                Level 1
#> 171                              Level 1                                Level 1
#> 172                              Level 9                                Level 1
#> 173                              Level 1                                Level 1
#> 174                              Level 1                                Level 1
#> 175                              Level 1                                Level 1
#> 176                              Level 1                                Level 1
#> 177                              Level 1                                Level 1
#> 178                              Level 1                                Level 1
#> 179                              Level 1                                Level 1
#> 180                              Level 1                                Level 1
#> 181                              Level 1                                Level 1
#> 182                              Level 1                                Level 1
#> 183                              Level 1                                Level 1
#> 184                              Level 1                                Level 1
#> 185                              Level 1                                Level 1
#> 186                              Level 1                                Level 1
#> 187                              Level 1                                Level 1
#> 188                              Level 1                                Level 1
#> 189                              Level 1                                Level 1
#> 190                              Level 1                                Level 1
#> 191                              Level 1                                Level 1
#> 192                              Level 1                                Level 1
#> 193                              Level 1                                Level 1
#> 194                              Level 1                                Level 1
#> 195                              Level 1                                Level 1
#> 196                              Level 1                                Level 1
#> 197                              Level 1                                Level 1
#> 198                              Level 1                                Level 1
#> 199                              Level 1                                Level 1
#> 200                              Level 1                                Level 2
#> 201                              Level 1                                Level 3
#> 202                              Level 1                                Level 1
#> 203                              Level 1                                Level 4
#> 204                              Level 1                                Level 1
#> 205                              Level 1                                Level 5
#> 206                              Level 1                                Level 1
#> 207                              Level 2                                Level 2
#> 208                              Level 2                                Level 4
#> 209                              Level 2                                Level 1
#> 210                              Level 2                                Level 5
#> 211                              Level 4                                Level 1
#> 212                              Level 2                                Level 6
#> 213                              Level 3                                Level 5
#> 214                              Level 3                                Level 2
#> 215                              Level 6                                Level 1
#> 216                              Level 3                                Level 1
#> 217                              Level 3                                Level 7
#> 218                              Level 4                                Level 6
#> 219                              Level 4                                Level 7
#> 220                              Level 1                                Level 2
#> 221                              Level 4                                Level 8
#> 222                              Level 5                                Level 7
#> 223                              Level 5                                Level 8
#> 224                              Level 5                                Level 9
#> 225                              Level 6                                Level 8
#> 226                              Level 6                                Level 9
#> 227                              Level 6                                Level 1
#> 228                              Level 7                                Level 9
#> 229                              Level 7                                Level 1
#> 230                              Level 7                                Level 1
#> 231                              Level 8                                Level 1
#> 232                              Level 8                                Level 1
#> 233                              Level 8                                Level 1
#> 234                              Level 9                                Level 1
#> 235                              Level 9                                Level 1
#> 236                              Level 9                                Level 1
#> 237                              Level 1                                Level 1
#> 238                              Level 1                                Level 1
#> 239                              Level 1                                Level 1
#> 240                              Level 1                                Level 1
#> 241                              Level 1                                Level 1
#> 242                              Level 1                                Level 1
#> 243                              Level 1                                Level 1
#> 244                              Level 1                                Level 1
#> 245                              Level 1                                Level 1
#> 246                              Level 1                                Level 1
#> 247                              Level 1                                Level 1
#> 248                              Level 1                                Level 1
#> 249                              Level 1                                Level 1
#> 250                              Level 1                                Level 1
#> 251                              Level 1                                Level 1
#> 252                              Level 1                                Level 1
#> 253                              Level 1                                Level 1
#> 254                              Level 1                                Level 1
#> 255                              Level 1                                Level 1
#> 256                              Level 1                                Level 1
#> 257                              Level 1                                Level 2
#> 258                              Level 1                                Level 1
#> 259                              Level 1                                Level 2
#> 260                              Level 1                                Level 2
#> 261                              Level 1                                Level 2
#> 262                              Level 1                                Level 2
#> 263                              Level 1                                Level 2
#> 264                              Level 1                                Level 2
#> 265                              Level 1                                Level 2
#> 266                              Level 1                                Level 2
#> 267                              Level 2                                Level 2
#> 268                              Level 2                                Level 2
#> 269                              Level 2                                Level 2
#> 270                              Level 2                                Level 2
#> 271                              Level 2                                Level 2
#> 272                              Level 2                                Level 2
#> 273                              Level 2                                Level 2
#> 274                              Level 2                                Level 1
#> 275                              Level 2                                Level 2
#> 276                              Level 2                                Level 2
#> 277                              Level 2                                Level 2
#> 278                              Level 2                                Level 2
#> 279                              Level 2                                Level 2
#> 280                              Level 2                                Level 2
#> 281                              Level 2                                Level 2
#> 282                              Level 2                                Level 2
#> 283                              Level 2                                Level 2
#> 284                              Level 2                                Level 2
#> 285                              Level 2                                Level 2
#> 286                              Level 2                                Level 2
#> 287                              Level 2                                Level 3
#> 288                              Level 2                                Level 1
#> 289                              Level 2                                Level 3
#> 290                              Level 2                                Level 3
#> 291                              Level 2                                Level 3
#> 292                              Level 2                                Level 3
#> 293                              Level 2                                Level 3
#> 294                              Level 2                                Level 3
#> 295                              Level 2                                Level 3
#> 296                              Level 2                                Level 3
#> 297                              Level 3                                Level 3
#> 298                              Level 3                                Level 3
#> 299                              Level 3                                Level 3
#> 300                              Level 3                                Level 3
#> 301                              Level 3                                Level 3
#> 302                              Level 3                                Level 3
#> 303                              Level 3                                Level 3
#> 304                              Level 3                                Level 1
#> 305                              Level 3                                Level 3
#> 306                              Level 3                                Level 4
#> 307                              Level 3                                Level 1
#> 308                              Level 3                                Level 3
#> 309                              Level 3                                Level 3
#> 310                              Level 3                                Level 3
#> 311                              Level 3                                Level 3
#> 312                              Level 3                                Level 3
#> 313                              Level 3                                Level 3
#> 314                              Level 3                                Level 3
#> 315                              Level 3                                Level 3
#> 316                              Level 3                                Level 3
#> 317                              Level 3                                Level 4
#> 318                              Level 3                                Level 1
#> 319                              Level 3                                Level 4
#> 320                              Level 3                                Level 4
#> 321                              Level 3                                Level 4
#> 322                              Level 3                                Level 4
#> 323                              Level 3                                Level 1
#> 324                              Level 3                                Level 4
#> 325                              Level 3                                Level 4
#> 326                              Level 3                                Level 4
#> 327                              Level 4                                Level 4
#> 328                              Level 4                                Level 4
#> 329                              Level 4                                Level 4
#> 330                              Level 4                                Level 4
#> 331                              Level 4                                Level 4
#> 332                              Level 4                                Level 4
#> 333                              Level 4                                Level 1
#> 334                              Level 4                                Level 4
#> 335                              Level 4                                Level 4
#> 336                              Level 4                                Level 4
#> 337                              Level 4                                Level 4
#> 338                              Level 4                                Level 4
#> 339                              Level 4                                Level 4
#> 340                              Level 4                                Level 4
#> 341                              Level 4                                Level 4
#> 342                              Level 4                                Level 4
#> 343                              Level 4                                Level 4
#> 344                              Level 4                                Level 4
#> 345                              Level 4                                Level 4
#> 346                              Level 4                                Level 4
#> 347                              Level 4                                Level 5
#> 348                              Level 4                                Level 4
#> 349                              Level 4                                Level 5
#> 350                              Level 4                                Level 5
#> 351                              Level 4                                Level 5
#> 352                              Level 4                                Level 5
#> 353                              Level 4                                Level 5
#> 354                              Level 4                                Level 5
#> 355                              Level 5                                Level 1
#> 356                              Level 4                                Level 5
#> 357                              Level 5                                Level 5
#> 358                              Level 5                                Level 1
#> 359                              Level 5                                Level 5
#> 360                              Level 5                                Level 5
#> 361                              Level 5                                Level 5
#> 362                              Level 5                                Level 5
#> 363                              Level 5                                Level 1
#> 364                              Level 5                                Level 5
#> 365                              Level 5                                Level 5
#> 366                              Level 5                                Level 5
#> 367                              Level 5                                Level 5
#> 368                              Level 5                                Level 5
#> 369                              Level 5                                Level 1
#> 370                              Level 5                                Level 5
#> 371                              Level 5                                Level 5
#> 372                              Level 5                                Level 5
#> 373                              Level 5                                Level 1
#> 374                              Level 5                                Level 5
#> 375                              Level 5                                Level 6
#> 376                              Level 5                                Level 5
#> 377                              Level 5                                Level 6
#> 378                              Level 5                                Level 5
#> 379                              Level 5                                Level 6
#> 380                              Level 6                                Level 1
#> 381                              Level 5                                Level 6
#> 382                              Level 5                                Level 6
#> 383                              Level 5                                Level 6
#> 384                              Level 5                                Level 6
#> 385                              Level 5                                Level 6
#> 386                              Level 5                                Level 6
#> 387                              Level 6                                Level 6
#> 388                              Level 6                                Level 6
#> 389                              Level 6                                Level 6
#> 390                              Level 6                                Level 6
#> 391                              Level 6                                Level 6
#> 392                              Level 6                                Level 6
#> 393                              Level 6                                Level 6
#> 394                              Level 6                                Level 6
#> 395                              Level 6                                Level 6
#> 396                              Level 6                                Level 6
#> 397                              Level 6                                Level 6
#> 398                              Level 6                                Level 6
#> 399                              Level 6                                Level 6
#> 400                              Level 6                                Level 8
#> 401                              Level 6                                Level 6
#> 402                              Level 6                                Level 6
#> 403                              Level 6                                Level 6
#> 404                              Level 6                                Level 6
#> 405                              Level 6                                Level 6
#> 406                              Level 6                                Level 6
#> 407                              Level 6                                Level 7
#> 408                              Level 6                                Level 6
#> 409                              Level 6                                Level 7
#> 410                              Level 6                                Level 7
#> 411                              Level 6                                Level 7
#> 412                              Level 6                                Level 7
#> 413                              Level 6                                Level 7
#> 414                              Level 6                                Level 7
#> 415                              Level 6                                Level 1
#> 416                              Level 6                                Level 7
#> 417                              Level 7                                Level 7
#> 418                              Level 7                                Level 7
#> 419                              Level 7                                Level 7
#> 420                              Level 7                                Level 7
#> 421                              Level 7                                Level 7
#> 422                              Level 7                                Level 7
#> 423                              Level 7                                Level 7
#> 424                              Level 7                                Level 7
#> 425                              Level 7                                Level 7
#> 426                              Level 7                                Level 7
#> 427                              Level 7                                Level 7
#> 428                              Level 7                                Level 7
#> 429                              Level 7                                Level 7
#> 430                              Level 7                                Level 7
#> 431                              Level 7                                Level 7
#> 432                              Level 7                                Level 1
#> 433                              Level 7                                Level 7
#> 434                              Level 7                                Level 7
#> 435                              Level 7                                Level 7
#> 436                              Level 7                                Level 7
#> 437                              Level 7                                Level 8
#> 438                              Level 7                                Level 7
#> 439                              Level 7                                Level 8
#> 440                              Level 7                                Level 8
#> 441                              Level 7                                Level 8
#> 442                              Level 7                                Level 8
#> 443                              Level 7                                Level 8
#> 444                              Level 7                                Level 1
#> 445                              Level 7                                Level 8
#> 446                              Level 7                                Level 8
#> 447                              Level 8                                Level 1
#> 448                              Level 8                                Level 8
#> 449                              Level 8                                Level 8
#> 450                              Level 8                                Level 8
#> 451                              Level 8                                Level 8
#> 452                              Level 8                                Level 8
#> 453                              Level 8                                Level 8
#> 454                              Level 1                                Level 8
#> 455                              Level 8                                Level 8
#> 456                              Level 8                                Level 8
#> 457                              Level 8                                Level 8
#> 458                              Level 8                                Level 8
#> 459                              Level 8                                Level 8
#> 460                              Level 8                                Level 8
#> 461                              Level 8                                Level 8
#> 462                              Level 8                                Level 8
#> 463                              Level 8                                Level 8
#> 464                              Level 8                                Level 8
#> 465                              Level 8                                Level 8
#> 466                              Level 8                                Level 8
#> 467                              Level 8                                Level 9
#> 468                              Level 8                                Level 9
#> 469                              Level 8                                Level 9
#> 470                              Level 8                                Level 9
#> 471                              Level 8                                Level 9
#> 472                              Level 8                                Level 9
#> 473                              Level 8                                Level 9
#> 474                              Level 8                                Level 9
#> 475                              Level 8                                Level 9
#> 476                              Level 8                                Level 9
#> 477                              Level 9                                Level 1
#> 478                              Level 9                                Level 9
#> 479                              Level 9                                Level 9
#> 480                              Level 9                                Level 9
#> 481                              Level 2                                Level 9
#> 482                              Level 9                                Level 9
#> 483                              Level 9                                Level 9
#> 484                              Level 9                                Level 9
#> 485                              Level 9                                Level 9
#> 486                              Level 9                                Level 1
#> 487                              Level 9                                Level 9
#> 488                              Level 7                                Level 9
#> 489                              Level 9                                Level 9
#> 490                              Level 9                                Level 9
#> 491                              Level 9                                Level 9
#> 492                              Level 9                                Level 9
#> 493                              Level 9                                Level 9
#> 494                              Level 9                                Level 9
#> 495                              Level 9                                Level 9
#> 496                              Level 9                                Level 9
#> 497                              Level 9                                Level 1
#> 498                              Level 9                                Level 9
#> 499                              Level 9                                Level 1
#> 500                              Level 9                                Level 1
#> 501                              Level 9                                Level 1
#> 502                              Level 9                                Level 1
#> 503                              Level 9                                Level 1
#> 504                              Level 9                                Level 1
#> 505                              Level 9                                Level 1
#> 506                              Level 9                                Level 1
#> 507                              Level 1                                Level 1
#> 508                              Level 1                                Level 1
#> 509                              Level 1                                Level 1
#> 510                              Level 1                                Level 1
#> 511                              Level 1                                Level 1
#> 512                              Level 1                                Level 1
#> 513                              Level 1                                Level 1
#> 514                              Level 1                                Level 1
#> 515                              Level 3                                Level 1
#> 516                              Level 1                                Level 1
#> 517                              Level 1                                Level 1
#> 518                              Level 1                                Level 1
#> 519                              Level 1                                Level 1
#> 520                              Level 1                                Level 1
#> 521                              Level 1                                Level 1
#> 522                              Level 1                                Level 1
#> 523                              Level 1                                Level 1
#> 524                              Level 1                                Level 1
#> 525                              Level 1                                Level 1
#> 526                              Level 1                                Level 1
#> 527                              Level 1                                Level 1
#> 528                              Level 1                                Level 1
#> 529                              Level 1                                Level 1
#> 530                              Level 1                                Level 1
#> 531                              Level 1                                Level 1
#> 532                              Level 1                                Level 1
#> 533                              Level 1                                Level 1
#> 534                              Level 1                                Level 1
#> 535                              Level 1                                Level 1
#> 536                              Level 1                                Level 1
#> 537                              Level 1                                Level 1
#> 538                              Level 1                                Level 1
#> 539                              Level 1                                Level 1
#> 540                              Level 1                                Level 1
#> 541                              Level 1                                Level 1
#> 542                              Level 1                                Level 1
#> 543                              Level 1                                Level 1
#> 544                              Level 1                                Level 1
#> 545                              Level 1                                Level 1
#> 546                              Level 1                                Level 1
#> 547                              Level 1                                Level 1
#> 548                              Level 1                                Level 1
#> 549                              Level 1                                Level 1
#> 550                              Level 1                                Level 1
#> 551                              Level 1                                Level 1
#> 552                              Level 1                                Level 1
#> 553                              Level 1                                Level 1
#> 554                              Level 1                                Level 1
#> 555                              Level 1                                Level 1
#> 556                              Level 1                                Level 1
#> 557                              Level 1                                Level 1
#> 558                              Level 1                                Level 1
#> 559                              Level 1                                Level 1
#> 560                              Level 1                                Level 1
#> 561                              Level 1                                Level 1
#> 562                              Level 1                                Level 1
#> 563                              Level 1                                Level 1
#> 564                              Level 1                                Level 1
#> 565                              Level 1                                Level 1
#> 566                              Level 1                                Level 1
#> 567                              Level 1                                Level 1
#> 568                              Level 1                                Level 1
#> 569                              Level 1                                Level 1
#> 570                              Level 1                                Level 1
#> 571                              Level 1                                Level 1
#> 572                              Level 1                                Level 1
#> 573                              Level 1                                Level 1
#> 574                              Level 1                                Level 1
#> 575                              Level 1                                Level 1
#> 576                              Level 1                                Level 1
#> 577                              Level 1                                Level 1
#> 578                              Level 1                                Level 1
#> 579                              Level 1                                Level 1
#> 580                              Level 1                                Level 1
#> 581                              Level 1                                Level 1
#> 582                              Level 1                                Level 1
#> 583                              Level 1                                Level 1
#> 584                              Level 1                                Level 1
#> 585                              Level 1                                Level 1
#> 586                              Level 1                                Level 1
#> 587                              Level 1                                Level 1
#> 588                              Level 1                                Level 1
#> 589                              Level 1                                Level 1
#> 590                              Level 1                                Level 1
#> 591                              Level 1                                Level 1
#> 592                              Level 1                                Level 1
#> 593                              Level 1                                Level 1
#> 594                              Level 1                                Level 1
#> 595                              Level 1                                Level 1
#> 596                              Level 1                                Level 1
#> 597                              Level 1                                Level 1
#> 598                              Level 1                                Level 1
#> 599                              Level 1                                Level 1
#> 600                              Level 1                                Level 1
#> 601                              Level 1                                Level 1
#> 602                              Level 1                                Level 1
#> 603                              Level 1                                Level 1
#> 604                              Level 1                                Level 1
#> 605                              Level 1                                Level 1
#> 606                              Level 1                                Level 1
#> 607                              Level 1                                Level 1
#> 608                              Level 1                                Level 1
#> 609                              Level 1                                Level 1
#> 610                              Level 1                                Level 1
#> 611                              Level 2                                Level 1
#> 612                              Level 1                                Level 1
#> 613                              Level 1                                Level 1
#> 614                              Level 1                                Level 1
#> 615                              Level 1                                Level 1
#> 616                              Level 1                                Level 1
#> 617                              Level 1                                Level 1
#> 618                              Level 9                                Level 1
#> 619                              Level 1                                Level 1
#> 620                              Level 1                                Level 1
#> 621                              Level 1                                Level 1
#> 622                              Level 1                                Level 1
#> 623                              Level 1                                Level 1
#> 624                              Level 1                                Level 1
#> 625                              Level 1                                Level 1
#> 626                              Level 1                                Level 1
#> 627                              Level 7                                Level 1
#> 628                              Level 1                                Level 1
#> 629                              Level 1                                Level 1
#> 630                              Level 6                                Level 1
#> 631                              Level 4                                Level 1
#> 632                              Level 1                                Level 1
#> 633                              Level 1                                Level 1
#> 634                              Level 1                                Level 1
#> 635                              Level 1                                Level 1
#> 636                              Level 1                                Level 1
#> 637                              Level 1                                Level 1
#> 638                              Level 1                                Level 1
#> 639                              Level 1                                Level 1
#> 640                              Level 1                                Level 1
#> 641                              Level 1                                Level 1
#> 642                              Level 9                                Level 1
#> 643                              Level 1                                Level 1
#> 644                              Level 1                                Level 1
#> 645                              Level 1                                Level 1
#> 646                              Level 1                                Level 1
#> 647                              Level 1                                Level 1
#> 648                              Level 1                                Level 1
#> 649                              Level 1                                Level 1
#> 650                              Level 1                                Level 1
#> 651                              Level 1                                Level 1
#> 652                              Level 1                                Level 1
#> 653                              Level 1                                Level 1
#> 654                              Level 1                                Level 1
#> 655                              Level 4                                Level 1
#> 656                              Level 1                                Level 1
#> 657                              Level 1                                Level 1
#> 658                              Level 1                                Level 1
#> 659                              Level 1                                Level 1
#> 660                              Level 1                                Level 1
#> 661                              Level 1                                Level 1
#> 662                              Level 1                                Level 1
#> 663                              Level 1                                Level 1
#> 664                              Level 1                                Level 1
#> 665                              Level 1                                Level 1
#> 666                              Level 1                                Level 1
#> 667                              Level 1                                Level 1
#> 668                              Level 1                                Level 1
#> 669                              Level 1                                Level 1
#> 670                              Level 1                                Level 1
#> 671                              Level 1                                Level 1
#> 672                              Level 1                                Level 1
#> 673                              Level 1                                Level 1
#> 674                              Level 1                                Level 1
#> 675                              Level 1                                Level 1
#> 676                              Level 1                                Level 1
#> 677                              Level 1                                Level 1
#> 678                              Level 1                                Level 1
#> 679                              Level 5                                Level 1
#> 680                              Level 1                                Level 1
#> 681                              Level 1                                Level 1
#> 682                              Level 1                                Level 1
#> 683                              Level 1                                Level 1
#> 684                              Level 1                                Level 1
#> 685                              Level 1                                Level 1
#> 686                              Level 1                                Level 1
#> 687                              Level 2                                Level 1
#> 688                              Level 1                                Level 1
#> 689                              Level 5                                Level 1
#> 690                              Level 1                                Level 1
#> 691                              Level 1                                Level 1
#> 692                              Level 1                                Level 1
#> 693                              Level 1                                Level 1
#> 694                              Level 1                                Level 1
#> 695                              Level 1                                Level 1
#> 696                              Level 1                                Level 1
#> 697                              Level 1                                Level 1
#> 698                              Level 1                                Level 1
#> 699                              Level 1                                Level 1
#> 700                              Level 1                                Level 1
#> 701                              Level 1                                Level 1
#> 702                              Level 1                                Level 1
#> 703                              Level 1                                Level 1
#> 704                              Level 1                                Level 1
#> 705                              Level 1                                Level 1
#> 706                              Level 1                                Level 1
#> 707                              Level 1                                Level 1
#> 708                              Level 1                                Level 1
#> 709                              Level 5                                Level 1
#> 710                              Level 1                                Level 1
#> 711                              Level 1                                Level 1
#> 712                              Level 1                                Level 1
#> 713                              Level 1                                Level 1
#> 714                              Level 1                                Level 1
#> 715                              Level 1                                Level 1
#> 716                              Level 1                                Level 1
#> 717                              Level 1                                Level 1
#> 718                              Level 1                                Level 1
#> 719                              Level 1                                Level 1
#> 720                              Level 1                                Level 1
#> 721                              Level 1                                Level 1
#> 722                              Level 1                                Level 1
#> 723                              Level 1                                Level 1
#> 724                              Level 1                                Level 1
#> 725                              Level 1                                Level 1
#> 726                              Level 1                                Level 1
#> 727                              Level 8                                Level 1
#> 728                              Level 1                                Level 1
#> 729                              Level 1                                Level 1
#> 730                              Level 1                                Level 1
#> 731                              Level 1                                Level 1
#> 732                              Level 1                                Level 1
#> 733                              Level 1                                Level 1
#> 734                              Level 1                                Level 1
#> 735                              Level 1                                Level 1
#> 736                              Level 1                                Level 1
#> 737                              Level 1                                Level 1
#> 738                              Level 1                                Level 1
#> 739                              Level 1                                Level 1
#> 740                              Level 1                                Level 1
#> 741                              Level 1                                Level 1
#> 742                              Level 1                                Level 1
#> 743                              Level 1                                Level 1
#> 744                              Level 1                                Level 1
#> 745                              Level 1                                Level 1
#> 746                              Level 1                                Level 1
#> 747                              Level 1                                Level 1
#> 748                              Level 1                                Level 1
#> 749                              Level 1                                Level 1
#> 750                              Level 1                                Level 1
#> 751                              Level 1                                Level 1
#> 752                              Level 1                                Level 1
#> 753                              Level 1                                Level 1
#> 754                              Level 1                                Level 1
#> 755                              Level 1                                Level 1
#> 756                              Level 1                                Level 1
#> 757                              Level 1                                Level 1
#> 758                              Level 1                                Level 1
#> 759                              Level 1                                Level 1
#> 760                              Level 1                                Level 1
#> 761                              Level 1                                Level 1
#> 762                              Level 1                                Level 1
#> 763                              Level 1                                Level 1
#> 764                              Level 1                                Level 1
#> 765                              Level 1                                Level 1
#> 766                              Level 1                                Level 1
#> 767                              Level 1                                Level 1
#> 768                              Level 1                                Level 1
#> 769                              Level 1                                Level 1
#> 770                              Level 1                                Level 1
#> 771                              Level 1                                Level 1
#> 772                              Level 1                                Level 1
#> 773                              Level 1                                Level 1
#> 774                              Level 1                                Level 1
#> 775                              Level 1                                Level 1
#> 776                              Level 1                                Level 1
#> 777                              Level 1                                Level 1
#> 778                              Level 1                                Level 1
#> 779                              Level 1                                Level 1
#> 780                              Level 1                                Level 1
#> 781                              Level 1                                Level 1
#> 782                              Level 1                                Level 1
#> 783                              Level 1                                Level 1
#> 784                              Level 1                                Level 1
#> 785                              Level 1                                Level 1
#> 786                              Level 1                                Level 1
#> 787                              Level 1                                Level 1
#> 788                              Level 1                                Level 1
#> 789                              Level 1                                Level 1
#> 790                              Level 1                                Level 1
#> 791                              Level 1                                Level 1
#> 792                              Level 1                                Level 1
#> 793                              Level 7                                Level 1
#> 794                              Level 1                                Level 1
#> 795                              Level 1                                Level 1
#> 796                              Level 1                                Level 1
#> 797                              Level 1                                Level 2
#> 798                              Level 1                                Level 1
#> 799                              Level 1                                Level 2
#> 800                              Level 1                                Level 2
#>     PrimaryCollaborator_City SecondaryCollaborator_City StrongTieScore
#> 1                     City C                     City B              1
#> 2                     City B                     City A              1
#> 3                     City A                     City B              1
#> 4                     City B                     City C              1
#> 5                     City C                     City A              1
#> 6                     City A                     City C              1
#> 7                     City C                     City B              1
#> 8                     City B                     City A              1
#> 9                     City A                     City B              1
#> 10                    City C                     City C              1
#> 11                    City C                     City A              1
#> 12                    City A                     City C              1
#> 13                    City C                     City B              1
#> 14                    City B                     City A              1
#> 15                    City A                     City B              1
#> 16                    City B                     City C              1
#> 17                    City C                     City A              1
#> 18                    City A                     City C              1
#> 19                    City C                     City B              1
#> 20                    City B                     City A              1
#> 21                    City A                     City B              1
#> 22                    City B                     City C              1
#> 23                    City C                     City A              1
#> 24                    City A                     City C              1
#> 25                    City C                     City B              1
#> 26                    City B                     City A              1
#> 27                    City A                     City B              1
#> 28                    City B                     City C              1
#> 29                    City C                     City A              1
#> 30                    City A                     City C              1
#> 31                    City C                     City B              1
#> 32                    City B                     City A              1
#> 33                    City A                     City B              1
#> 34                    City C                     City B              1
#> 35                    City C                     City A              1
#> 36                    City A                     City C              1
#> 37                    City C                     City B              1
#> 38                    City B                     City A              1
#> 39                    City A                     City B              1
#> 40                    City B                     City C              1
#> 41                    City C                     City A              1
#> 42                    City C                     City A              1
#> 43                    City C                     City B              1
#> 44                    City B                     City A              1
#> 45                    City A                     City B              1
#> 46                    City B                     City C              1
#> 47                    City C                     City A              1
#> 48                    City A                     City C              1
#> 49                    City C                     City B              1
#> 50                    City B                     City A              1
#> 51                    City A                     City B              1
#> 52                    City B                     City C              1
#> 53                    City C                     City A              1
#> 54                    City A                     City C              1
#> 55                    City C                     City A              1
#> 56                    City B                     City A              1
#> 57                    City A                     City B              1
#> 58                    City B                     City C              1
#> 59                    City C                     City A              1
#> 60                    City A                     City C              1
#> 61                    City A                     City B              1
#> 62                    City B                     City A              1
#> 63                    City A                     City B              1
#> 64                    City B                     City C              1
#> 65                    City C                     City A              1
#> 66                    City A                     City C              1
#> 67                    City C                     City B              1
#> 68                    City B                     City A              1
#> 69                    City A                     City B              1
#> 70                    City B                     City C              1
#> 71                    City C                     City A              1
#> 72                    City A                     City C              1
#> 73                    City C                     City B              1
#> 74                    City B                     City A              1
#> 75                    City A                     City B              1
#> 76                    City B                     City C              1
#> 77                    City C                     City A              1
#> 78                    City A                     City C              1
#> 79                    City C                     City B              1
#> 80                    City B                     City A              1
#> 81                    City A                     City B              1
#> 82                    City B                     City C              1
#> 83                    City C                     City A              1
#> 84                    City A                     City C              1
#> 85                    City C                     City B              1
#> 86                    City B                     City A              1
#> 87                    City A                     City B              1
#> 88                    City B                     City C              1
#> 89                    City C                     City A              1
#> 90                    City A                     City C              1
#> 91                    City C                     City B              1
#> 92                    City B                     City A              1
#> 93                    City A                     City B              1
#> 94                    City C                     City C              1
#> 95                    City C                     City A              1
#> 96                    City A                     City C              1
#> 97                    City C                     City B              1
#> 98                    City B                     City A              1
#> 99                    City A                     City B              1
#> 100                   City B                     City C              1
#> 101                   City C                     City A              1
#> 102                   City A                     City C              1
#> 103                   City C                     City B              1
#> 104                   City B                     City A              1
#> 105                   City A                     City B              1
#> 106                   City B                     City C              1
#> 107                   City C                     City A              1
#> 108                   City A                     City C              1
#> 109                   City C                     City B              1
#> 110                   City B                     City C              1
#> 111                   City B                     City C              1
#> 112                   City B                     City C              1
#> 113                   City C                     City A              1
#> 114                   City A                     City C              1
#> 115                   City C                     City B              1
#> 116                   City B                     City A              1
#> 117                   City A                     City B              1
#> 118                   City B                     City C              1
#> 119                   City C                     City A              1
#> 120                   City A                     City C              1
#> 121                   City C                     City B              1
#> 122                   City B                     City A              1
#> 123                   City A                     City B              1
#> 124                   City B                     City C              1
#> 125                   City C                     City A              1
#> 126                   City A                     City C              1
#> 127                   City C                     City B              1
#> 128                   City B                     City A              1
#> 129                   City A                     City B              1
#> 130                   City B                     City C              1
#> 131                   City C                     City A              1
#> 132                   City A                     City C              1
#> 133                   City C                     City B              1
#> 134                   City B                     City A              1
#> 135                   City A                     City B              1
#> 136                   City B                     City C              1
#> 137                   City C                     City A              1
#> 138                   City A                     City C              1
#> 139                   City C                     City B              1
#> 140                   City B                     City A              1
#> 141                   City A                     City B              1
#> 142                   City B                     City C              1
#> 143                   City C                     City A              1
#> 144                   City A                     City C              1
#> 145                   City C                     City B              1
#> 146                   City B                     City A              1
#> 147                   City A                     City B              1
#> 148                   City B                     City C              1
#> 149                   City C                     City A              1
#> 150                   City A                     City C              1
#> 151                   City C                     City B              1
#> 152                   City B                     City A              1
#> 153                   City A                     City B              1
#> 154                   City B                     City C              1
#> 155                   City C                     City A              1
#> 156                   City A                     City C              1
#> 157                   City C                     City B              1
#> 158                   City B                     City A              1
#> 159                   City A                     City B              1
#> 160                   City B                     City C              1
#> 161                   City A                     City C              1
#> 162                   City A                     City C              1
#> 163                   City A                     City B              1
#> 164                   City B                     City A              1
#> 165                   City A                     City B              1
#> 166                   City B                     City C              1
#> 167                   City C                     City A              1
#> 168                   City A                     City C              1
#> 169                   City C                     City B              1
#> 170                   City C                     City B              1
#> 171                   City A                     City B              1
#> 172                   City A                     City B              1
#> 173                   City C                     City A              1
#> 174                   City A                     City C              1
#> 175                   City C                     City B              1
#> 176                   City A                     City A              1
#> 177                   City A                     City B              1
#> 178                   City B                     City C              1
#> 179                   City C                     City A              1
#> 180                   City A                     City C              1
#> 181                   City C                     City B              1
#> 182                   City B                     City A              1
#> 183                   City C                     City A              1
#> 184                   City B                     City C              1
#> 185                   City C                     City A              1
#> 186                   City A                     City C              1
#> 187                   City C                     City B              1
#> 188                   City B                     City A              1
#> 189                   City A                     City B              1
#> 190                   City B                     City C              1
#> 191                   City C                     City A              1
#> 192                   City A                     City C              1
#> 193                   City C                     City B              1
#> 194                   City B                     City A              1
#> 195                   City A                     City B              1
#> 196                   City B                     City C              1
#> 197                   City C                     City A              1
#> 198                   City A                     City C              1
#> 199                   City B                     City C              1
#> 200                   City C                     City B              1
#> 201                   City C                     City A              1
#> 202                   City C                     City C              1
#> 203                   City C                     City B              1
#> 204                   City C                     City A              1
#> 205                   City C                     City C              1
#> 206                   City C                     City C              1
#> 207                   City B                     City B              1
#> 208                   City B                     City B              1
#> 209                   City B                     City C              1
#> 210                   City B                     City C              1
#> 211                   City B                     City B              1
#> 212                   City B                     City A              1
#> 213                   City A                     City C              1
#> 214                   City A                     City B              1
#> 215                   City A                     City B              1
#> 216                   City A                     City C              1
#> 217                   City A                     City C              1
#> 218                   City B                     City A              1
#> 219                   City B                     City C              1
#> 220                   City A                     City B              1
#> 221                   City B                     City B              1
#> 222                   City C                     City C              1
#> 223                   City C                     City B              1
#> 224                   City C                     City A              1
#> 225                   City A                     City B              1
#> 226                   City A                     City A              1
#> 227                   City A                     City B              1
#> 228                   City C                     City A              1
#> 229                   City C                     City B              1
#> 230                   City C                     City C              1
#> 231                   City B                     City B              1
#> 232                   City B                     City C              1
#> 233                   City B                     City A              1
#> 234                   City A                     City C              1
#> 235                   City A                     City A              1
#> 236                   City A                     City C              1
#> 237                   City B                     City A              1
#> 238                   City C                     City B              1
#> 239                   City B                     City B              1
#> 240                   City C                     City C              1
#> 241                   City C                     City B              1
#> 242                   City C                     City A              1
#> 243                   City A                     City B              1
#> 244                   City A                     City A              1
#> 245                   City A                     City B              1
#> 246                   City C                     City A              1
#> 247                   City C                     City B              1
#> 248                   City C                     City C              1
#> 249                   City B                     City B              1
#> 250                   City B                     City C              1
#> 251                   City B                     City A              1
#> 252                   City A                     City C              1
#> 253                   City A                     City A              1
#> 254                   City A                     City C              1
#> 255                   City B                     City A              1
#> 256                   City B                     City C              1
#> 257                   City B                     City B              1
#> 258                   City C                     City C              1
#> 259                   City C                     City B              1
#> 260                   City C                     City A              1
#> 261                   City A                     City B              1
#> 262                   City A                     City A              1
#> 263                   City A                     City B              1
#> 264                   City C                     City A              1
#> 265                   City C                     City B              1
#> 266                   City C                     City C              1
#> 267                   City B                     City B              1
#> 268                   City B                     City C              1
#> 269                   City B                     City A              1
#> 270                   City A                     City C              1
#> 271                   City A                     City A              1
#> 272                   City A                     City C              1
#> 273                   City B                     City A              1
#> 274                   City C                     City C              1
#> 275                   City B                     City B              1
#> 276                   City C                     City C              1
#> 277                   City C                     City B              1
#> 278                   City C                     City A              1
#> 279                   City A                     City B              1
#> 280                   City A                     City A              1
#> 281                   City A                     City B              1
#> 282                   City C                     City A              1
#> 283                   City C                     City B              1
#> 284                   City C                     City C              1
#> 285                   City B                     City B              1
#> 286                   City B                     City C              1
#> 287                   City B                     City A              1
#> 288                   City C                     City C              1
#> 289                   City A                     City A              1
#> 290                   City A                     City C              1
#> 291                   City B                     City A              1
#> 292                   City B                     City C              1
#> 293                   City B                     City B              1
#> 294                   City C                     City C              1
#> 295                   City C                     City B              1
#> 296                   City C                     City A              1
#> 297                   City A                     City B              1
#> 298                   City A                     City A              1
#> 299                   City A                     City B              1
#> 300                   City C                     City A              1
#> 301                   City C                     City B              1
#> 302                   City C                     City C              1
#> 303                   City B                     City B              1
#> 304                   City B                     City B              1
#> 305                   City B                     City A              1
#> 306                   City C                     City C              1
#> 307                   City A                     City A              1
#> 308                   City A                     City C              1
#> 309                   City B                     City A              1
#> 310                   City B                     City C              1
#> 311                   City B                     City B              1
#> 312                   City C                     City C              1
#> 313                   City C                     City B              1
#> 314                   City C                     City A              1
#> 315                   City A                     City B              1
#> 316                   City A                     City A              1
#> 317                   City A                     City B              1
#> 318                   City C                     City C              1
#> 319                   City C                     City B              1
#> 320                   City C                     City C              1
#> 321                   City B                     City B              1
#> 322                   City B                     City C              1
#> 323                   City B                     City B              1
#> 324                   City A                     City C              1
#> 325                   City A                     City A              1
#> 326                   City A                     City C              1
#> 327                   City B                     City A              1
#> 328                   City B                     City C              1
#> 329                   City B                     City B              1
#> 330                   City C                     City C              1
#> 331                   City C                     City B              1
#> 332                   City C                     City A              1
#> 333                   City A                     City B              1
#> 334                   City A                     City A              1
#> 335                   City A                     City B              1
#> 336                   City C                     City A              1
#> 337                   City C                     City B              1
#> 338                   City C                     City C              1
#> 339                   City B                     City B              1
#> 340                   City B                     City C              1
#> 341                   City B                     City A              1
#> 342                   City A                     City C              1
#> 343                   City A                     City A              1
#> 344                   City A                     City C              1
#> 345                   City B                     City A              1
#> 346                   City B                     City C              1
#> 347                   City B                     City B              1
#> 348                   City C                     City C              1
#> 349                   City C                     City B              1
#> 350                   City C                     City A              1
#> 351                   City A                     City B              1
#> 352                   City A                     City A              1
#> 353                   City A                     City B              1
#> 354                   City C                     City A              1
#> 355                   City B                     City C              1
#> 356                   City C                     City C              1
#> 357                   City B                     City B              1
#> 358                   City C                     City B              1
#> 359                   City B                     City A              1
#> 360                   City A                     City C              1
#> 361                   City A                     City A              1
#> 362                   City A                     City C              1
#> 363                   City B                     City A              1
#> 364                   City B                     City C              1
#> 365                   City B                     City B              1
#> 366                   City C                     City C              1
#> 367                   City C                     City B              1
#> 368                   City C                     City A              1
#> 369                   City A                     City A              1
#> 370                   City A                     City A              1
#> 371                   City A                     City B              1
#> 372                   City C                     City A              1
#> 373                   City B                     City B              1
#> 374                   City C                     City C              1
#> 375                   City B                     City A              1
#> 376                   City B                     City C              1
#> 377                   City B                     City A              1
#> 378                   City A                     City C              1
#> 379                   City A                     City A              1
#> 380                   City C                     City C              1
#> 381                   City B                     City A              1
#> 382                   City B                     City C              1
#> 383                   City B                     City B              1
#> 384                   City C                     City C              1
#> 385                   City C                     City B              1
#> 386                   City C                     City A              1
#> 387                   City A                     City B              1
#> 388                   City A                     City A              1
#> 389                   City A                     City B              1
#> 390                   City C                     City A              1
#> 391                   City C                     City B              1
#> 392                   City C                     City C              1
#> 393                   City B                     City B              1
#> 394                   City B                     City C              1
#> 395                   City B                     City A              1
#> 396                   City A                     City C              1
#> 397                   City A                     City A              1
#> 398                   City A                     City C              1
#> 399                   City B                     City A              1
#> 400                   City C                     City C              1
#> 401                   City B                     City B              1
#> 402                   City C                     City C              1
#> 403                   City C                     City B              1
#> 404                   City C                     City A              1
#> 405                   City A                     City B              1
#> 406                   City A                     City A              1
#> 407                   City A                     City B              1
#> 408                   City C                     City A              1
#> 409                   City C                     City B              1
#> 410                   City C                     City C              1
#> 411                   City B                     City B              1
#> 412                   City B                     City C              1
#> 413                   City B                     City A              1
#> 414                   City A                     City C              1
#> 415                   City A                     City A              1
#> 416                   City A                     City C              1
#> 417                   City B                     City A              1
#> 418                   City B                     City C              1
#> 419                   City B                     City B              1
#> 420                   City C                     City C              1
#> 421                   City C                     City B              1
#> 422                   City C                     City A              1
#> 423                   City A                     City B              1
#> 424                   City A                     City A              1
#> 425                   City A                     City B              1
#> 426                   City C                     City A              1
#> 427                   City C                     City B              1
#> 428                   City C                     City C              1
#> 429                   City B                     City B              1
#> 430                   City B                     City C              1
#> 431                   City B                     City A              1
#> 432                   City C                     City A              1
#> 433                   City A                     City A              1
#> 434                   City A                     City C              1
#> 435                   City B                     City A              1
#> 436                   City B                     City C              1
#> 437                   City B                     City B              1
#> 438                   City C                     City C              1
#> 439                   City C                     City B              1
#> 440                   City C                     City A              1
#> 441                   City A                     City B              1
#> 442                   City A                     City A              1
#> 443                   City A                     City B              1
#> 444                   City C                     City B              1
#> 445                   City C                     City B              1
#> 446                   City C                     City C              1
#> 447                   City B                     City C              1
#> 448                   City B                     City C              1
#> 449                   City B                     City A              1
#> 450                   City A                     City C              1
#> 451                   City A                     City A              1
#> 452                   City A                     City C              1
#> 453                   City B                     City A              1
#> 454                   City C                     City C              1
#> 455                   City B                     City B              1
#> 456                   City C                     City C              1
#> 457                   City C                     City B              1
#> 458                   City C                     City A              1
#> 459                   City A                     City B              1
#> 460                   City A                     City A              1
#> 461                   City A                     City B              1
#> 462                   City C                     City A              1
#> 463                   City C                     City B              1
#> 464                   City C                     City C              1
#> 465                   City B                     City B              1
#> 466                   City B                     City C              1
#> 467                   City B                     City A              1
#> 468                   City A                     City C              1
#> 469                   City A                     City A              1
#> 470                   City A                     City C              1
#> 471                   City B                     City A              1
#> 472                   City B                     City C              1
#> 473                   City B                     City B              1
#> 474                   City C                     City C              1
#> 475                   City C                     City B              1
#> 476                   City C                     City A              1
#> 477                   City A                     City C              1
#> 478                   City A                     City A              1
#> 479                   City A                     City B              1
#> 480                   City C                     City A              1
#> 481                   City C                     City B              1
#> 482                   City C                     City C              1
#> 483                   City B                     City B              1
#> 484                   City B                     City C              1
#> 485                   City B                     City A              1
#> 486                   City C                     City B              1
#> 487                   City A                     City A              1
#> 488                   City A                     City A              1
#> 489                   City B                     City A              1
#> 490                   City B                     City C              1
#> 491                   City B                     City B              1
#> 492                   City C                     City C              1
#> 493                   City C                     City B              1
#> 494                   City C                     City A              1
#> 495                   City A                     City B              1
#> 496                   City A                     City A              1
#> 497                   City A                     City B              1
#> 498                   City C                     City A              1
#> 499                   City C                     City B              1
#> 500                   City C                     City C              1
#> 501                   City B                     City B              1
#> 502                   City B                     City C              1
#> 503                   City B                     City A              1
#> 504                   City A                     City C              1
#> 505                   City A                     City A              1
#> 506                   City A                     City C              1
#> 507                   City A                     City C              1
#> 508                   City B                     City C              1
#> 509                   City B                     City B              1
#> 510                   City C                     City C              1
#> 511                   City C                     City B              1
#> 512                   City C                     City A              1
#> 513                   City A                     City B              1
#> 514                   City A                     City A              1
#> 515                   City A                     City B              1
#> 516                   City C                     City A              1
#> 517                   City C                     City B              1
#> 518                   City C                     City C              1
#> 519                   City B                     City B              1
#> 520                   City B                     City C              1
#> 521                   City B                     City A              1
#> 522                   City A                     City C              1
#> 523                   City A                     City A              1
#> 524                   City A                     City C              1
#> 525                   City B                     City A              1
#> 526                   City B                     City C              1
#> 527                   City B                     City B              1
#> 528                   City C                     City C              1
#> 529                   City C                     City B              1
#> 530                   City C                     City A              1
#> 531                   City A                     City B              1
#> 532                   City A                     City A              1
#> 533                   City A                     City B              1
#> 534                   City C                     City A              1
#> 535                   City C                     City B              1
#> 536                   City C                     City C              1
#> 537                   City B                     City B              1
#> 538                   City B                     City C              1
#> 539                   City B                     City A              1
#> 540                   City A                     City C              1
#> 541                   City A                     City A              1
#> 542                   City A                     City C              1
#> 543                   City B                     City A              1
#> 544                   City B                     City C              1
#> 545                   City B                     City B              1
#> 546                   City C                     City C              1
#> 547                   City C                     City B              1
#> 548                   City C                     City A              1
#> 549                   City A                     City B              1
#> 550                   City A                     City A              1
#> 551                   City A                     City B              1
#> 552                   City C                     City A              1
#> 553                   City C                     City B              1
#> 554                   City C                     City C              1
#> 555                   City B                     City B              1
#> 556                   City B                     City C              1
#> 557                   City B                     City A              1
#> 558                   City A                     City C              1
#> 559                   City A                     City A              1
#> 560                   City A                     City C              1
#> 561                   City B                     City A              1
#> 562                   City B                     City C              1
#> 563                   City B                     City B              1
#> 564                   City C                     City C              1
#> 565                   City C                     City B              1
#> 566                   City C                     City A              1
#> 567                   City A                     City B              1
#> 568                   City A                     City A              1
#> 569                   City A                     City B              1
#> 570                   City C                     City A              1
#> 571                   City C                     City B              1
#> 572                   City C                     City C              1
#> 573                   City B                     City B              1
#> 574                   City B                     City C              1
#> 575                   City B                     City A              1
#> 576                   City A                     City C              1
#> 577                   City A                     City A              1
#> 578                   City A                     City C              1
#> 579                   City B                     City A              1
#> 580                   City B                     City C              1
#> 581                   City B                     City B              1
#> 582                   City C                     City C              1
#> 583                   City C                     City B              1
#> 584                   City C                     City A              1
#> 585                   City A                     City B              1
#> 586                   City A                     City A              1
#> 587                   City A                     City B              1
#> 588                   City C                     City A              1
#> 589                   City C                     City B              1
#> 590                   City C                     City C              1
#> 591                   City B                     City B              1
#> 592                   City B                     City C              1
#> 593                   City B                     City A              1
#> 594                   City A                     City C              1
#> 595                   City A                     City A              1
#> 596                   City A                     City C              1
#> 597                   City B                     City A              1
#> 598                   City B                     City C              1
#> 599                   City B                     City B              1
#> 600                   City C                     City C              1
#> 601                   City C                     City B              1
#> 602                   City C                     City A              1
#> 603                   City A                     City B              1
#> 604                   City A                     City A              1
#> 605                   City A                     City B              1
#> 606                   City C                     City A              1
#> 607                   City C                     City B              1
#> 608                   City C                     City C              1
#> 609                   City B                     City B              1
#> 610                   City B                     City C              1
#> 611                   City A                     City A              1
#> 612                   City A                     City C              1
#> 613                   City A                     City A              1
#> 614                   City A                     City C              1
#> 615                   City B                     City A              1
#> 616                   City B                     City C              1
#> 617                   City B                     City B              1
#> 618                   City B                     City C              1
#> 619                   City C                     City B              1
#> 620                   City C                     City A              1
#> 621                   City A                     City B              1
#> 622                   City A                     City A              1
#> 623                   City A                     City B              1
#> 624                   City C                     City A              1
#> 625                   City C                     City B              1
#> 626                   City C                     City C              1
#> 627                   City C                     City B              1
#> 628                   City B                     City C              1
#> 629                   City B                     City A              1
#> 630                   City B                     City C              1
#> 631                   City C                     City A              1
#> 632                   City A                     City C              1
#> 633                   City A                     City A              1
#> 634                   City B                     City C              1
#> 635                   City B                     City B              1
#> 636                   City C                     City C              1
#> 637                   City B                     City B              1
#> 638                   City C                     City A              1
#> 639                   City A                     City B              1
#> 640                   City A                     City A              1
#> 641                   City A                     City B              1
#> 642                   City A                     City A              1
#> 643                   City C                     City B              1
#> 644                   City C                     City C              1
#> 645                   City B                     City B              1
#> 646                   City B                     City B              1
#> 647                   City A                     City A              1
#> 648                   City A                     City C              1
#> 649                   City A                     City A              1
#> 650                   City A                     City C              1
#> 651                   City B                     City A              1
#> 652                   City B                     City C              1
#> 653                   City B                     City B              1
#> 654                   City C                     City C              1
#> 655                   City A                     City C              1
#> 656                   City C                     City A              1
#> 657                   City A                     City B              1
#> 658                   City A                     City A              1
#> 659                   City A                     City B              1
#> 660                   City C                     City A              1
#> 661                   City C                     City B              1
#> 662                   City C                     City C              1
#> 663                   City B                     City B              1
#> 664                   City B                     City C              1
#> 665                   City B                     City A              1
#> 666                   City A                     City C              1
#> 667                   City A                     City A              1
#> 668                   City A                     City C              1
#> 669                   City B                     City A              1
#> 670                   City B                     City C              1
#> 671                   City B                     City B              1
#> 672                   City C                     City C              1
#> 673                   City C                     City B              1
#> 674                   City C                     City A              1
#> 675                   City A                     City B              1
#> 676                   City A                     City A              1
#> 677                   City A                     City B              1
#> 678                   City C                     City A              1
#> 679                   City B                     City C              1
#> 680                   City C                     City B              1
#> 681                   City B                     City B              1
#> 682                   City B                     City C              1
#> 683                   City B                     City A              1
#> 684                   City A                     City C              1
#> 685                   City A                     City A              1
#> 686                   City A                     City C              1
#> 687                   City A                     City B              1
#> 688                   City B                     City C              1
#> 689                   City A                     City B              1
#> 690                   City C                     City C              1
#> 691                   City C                     City B              1
#> 692                   City C                     City A              1
#> 693                   City A                     City B              1
#> 694                   City A                     City A              1
#> 695                   City A                     City B              1
#> 696                   City C                     City A              1
#> 697                   City C                     City B              1
#> 698                   City C                     City C              1
#> 699                   City B                     City B              1
#> 700                   City B                     City C              1
#> 701                   City B                     City A              1
#> 702                   City A                     City C              1
#> 703                   City A                     City A              1
#> 704                   City A                     City C              1
#> 705                   City B                     City A              1
#> 706                   City B                     City C              1
#> 707                   City B                     City B              1
#> 708                   City C                     City C              1
#> 709                   City C                     City C              1
#> 710                   City C                     City A              1
#> 711                   City A                     City B              1
#> 712                   City A                     City A              1
#> 713                   City A                     City B              1
#> 714                   City C                     City A              1
#> 715                   City C                     City B              1
#> 716                   City C                     City C              1
#> 717                   City B                     City B              1
#> 718                   City C                     City A              1
#> 719                   City B                     City A              1
#> 720                   City A                     City C              1
#> 721                   City A                     City A              1
#> 722                   City A                     City C              1
#> 723                   City B                     City A              1
#> 724                   City B                     City C              1
#> 725                   City B                     City B              1
#> 726                   City C                     City C              1
#> 727                   City B                     City A              1
#> 728                   City C                     City A              1
#> 729                   City A                     City B              1
#> 730                   City A                     City A              1
#> 731                   City A                     City B              1
#> 732                   City C                     City A              1
#> 733                   City C                     City B              1
#> 734                   City C                     City C              1
#> 735                   City B                     City B              1
#> 736                   City B                     City C              1
#> 737                   City B                     City A              1
#> 738                   City A                     City C              1
#> 739                   City A                     City A              1
#> 740                   City A                     City C              1
#> 741                   City B                     City A              1
#> 742                   City B                     City C              1
#> 743                   City B                     City B              1
#> 744                   City C                     City C              1
#> 745                   City C                     City B              1
#> 746                   City C                     City A              1
#> 747                   City A                     City B              1
#> 748                   City A                     City A              1
#> 749                   City A                     City B              1
#> 750                   City C                     City A              1
#> 751                   City C                     City B              1
#> 752                   City C                     City C              1
#> 753                   City B                     City B              1
#> 754                   City B                     City C              1
#> 755                   City B                     City A              1
#> 756                   City A                     City C              1
#> 757                   City B                     City A              1
#> 758                   City A                     City C              1
#> 759                   City B                     City A              1
#> 760                   City B                     City C              1
#> 761                   City B                     City B              1
#> 762                   City C                     City C              1
#> 763                   City C                     City B              1
#> 764                   City C                     City A              1
#> 765                   City A                     City B              1
#> 766                   City A                     City A              1
#> 767                   City A                     City B              1
#> 768                   City C                     City A              1
#> 769                   City C                     City B              1
#> 770                   City C                     City C              1
#> 771                   City B                     City B              1
#> 772                   City B                     City C              1
#> 773                   City B                     City A              1
#> 774                   City A                     City C              1
#> 775                   City A                     City A              1
#> 776                   City A                     City C              1
#> 777                   City B                     City A              1
#> 778                   City B                     City C              1
#> 779                   City B                     City B              1
#> 780                   City C                     City C              1
#> 781                   City C                     City B              1
#> 782                   City C                     City A              1
#> 783                   City A                     City B              1
#> 784                   City A                     City A              1
#> 785                   City A                     City B              1
#> 786                   City C                     City A              1
#> 787                   City C                     City B              1
#> 788                   City C                     City C              1
#> 789                   City B                     City B              1
#> 790                   City B                     City C              1
#> 791                   City B                     City A              1
#> 792                   City A                     City C              1
#> 793                   City C                     City A              1
#> 794                   City A                     City C              1
#> 795                   City B                     City A              1
#> 796                   City B                     City C              1
#> 797                   City B                     City B              1
#> 798                   City C                     City C              1
#> 799                   City C                     City B              1
#> 800                   City A                     City B              1
```
