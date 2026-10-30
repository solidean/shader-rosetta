






















float intBitsToFloat(int _x) { return asfloat(_x); }
float2 intBitsToFloat(uint2 _x) { return asfloat(_x); }
float3 intBitsToFloat(uint3 _x) { return asfloat(_x); }
float4 intBitsToFloat(uint4 _x) { return asfloat(_x); }

float uintBitsToFloat(uint _x) { return asfloat(_x); }
float2 uintBitsToFloat(uint2 _x) { return asfloat(_x); }
float3 uintBitsToFloat(uint3 _x) { return asfloat(_x); }
float4 uintBitsToFloat(uint4 _x) { return asfloat(_x); }

uint floatBitsToUint(float _x) { return asuint(_x); }
uint2 floatBitsToUint(float2 _x) { return asuint(_x); }
uint3 floatBitsToUint(float3 _x) { return asuint(_x); }
uint4 floatBitsToUint(float4 _x) { return asuint(_x); }

int floatBitsToInt(float _x) { return asint(_x); }
int2 floatBitsToInt(float2 _x) { return asint(_x); }
int3 floatBitsToInt(float3 _x) { return asint(_x); }
int4 floatBitsToInt(float4 _x) { return asint(_x); }

uint bitfieldReverse(uint _x) { return reversebits(_x); }
uint2 bitfieldReverse(uint2 _x) { return reversebits(_x); }
uint3 bitfieldReverse(uint3 _x) { return reversebits(_x); }
uint4 bitfieldReverse(uint4 _x) { return reversebits(_x); }

uint packHalf2x16(float2 _x)
{
return (f32tof16(_x.y)<<16) | f32tof16(_x.x);
}

float2 unpackHalf2x16(uint _x)
{
return float2(f16tof32(_x & 0xffff), f16tof32(_x >> 16) );
}

struct BgfxSampler2D
{
SamplerState m_sampler;
Texture2D m_texture;
};

struct BgfxISampler2D
{
Texture2D<int4> m_texture;
};

struct BgfxUSampler2D
{
Texture2D<uint4> m_texture;
};

struct BgfxSampler2DArray
{
SamplerState m_sampler;
Texture2DArray m_texture;
};

struct BgfxSampler2DShadow
{
SamplerComparisonState m_sampler;
Texture2D m_texture;
};

struct BgfxSampler2DArrayShadow
{
SamplerComparisonState m_sampler;
Texture2DArray m_texture;
};

struct BgfxSampler3D
{
SamplerState m_sampler;
Texture3D m_texture;
};

struct BgfxISampler3D
{
Texture3D<int4> m_texture;
};

struct BgfxUSampler3D
{
Texture3D<uint4> m_texture;
};

struct BgfxSamplerCube
{
SamplerState m_sampler;
TextureCube m_texture;
};

struct BgfxSamplerCubeArray
{
SamplerState m_sampler;
TextureCubeArray m_texture;
};

struct BgfxSamplerCubeShadow
{
SamplerComparisonState m_sampler;
TextureCube m_texture;
};

struct BgfxSampler2DMS
{
Texture2DMS<float4> m_texture;
};

struct BgfxSampler2DMSArray
{
Texture2DMSArray<float4> m_texture;
};

float4 bgfxTexture2D(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture2DBias(BgfxSampler2D _sampler, float2 _coord, float _bias)
{
return _sampler.m_texture.SampleBias(_sampler.m_sampler, _coord, _bias);
}

float4 bgfxTexture2DLod(BgfxSampler2D _sampler, float2 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTexture2DLodOffset(BgfxSampler2D _sampler, float2 _coord, float _level, int2 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}

float4 bgfxTexture2DProj(BgfxSampler2D _sampler, float3 _coord)
{
float2 coord = _coord.xy * rcp(_coord.z);
return _sampler.m_texture.Sample(_sampler.m_sampler, coord);
}

float4 bgfxTexture2DProj(BgfxSampler2D _sampler, float4 _coord)
{
float2 coord = _coord.xy * rcp(_coord.w);
return _sampler.m_texture.Sample(_sampler.m_sampler, coord);
}

float4 bgfxTexture2DGrad(BgfxSampler2D _sampler, float2 _coord, float2 _dPdx, float2 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float4 bgfxTexture2DArray(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture2DArrayLod(BgfxSampler2DArray _sampler, float3 _coord, float _lod)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _lod);
}

float4 bgfxTexture2DArrayLodOffset(BgfxSampler2DArray _sampler, float3 _coord, float _level, int2 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}

float3 bgfxTextureSize(BgfxSampler2DArray _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float bgfxShadow2D(BgfxSampler2DShadow _sampler, float3 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xy, _coord.z);
}

float bgfxShadow2DProj(BgfxSampler2DShadow _sampler, float4 _coord)
{
float3 coord = _coord.xyz * rcp(_coord.w);
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, coord.xy, coord.z);
}

float2 bgfxTextureSize(BgfxSampler2DShadow _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float bgfxShadow2DArray(BgfxSampler2DArrayShadow _sampler, float4 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xyz, _coord.w);
}

float3 bgfxTextureSize(BgfxSampler2DArrayShadow _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float4 bgfxTexture3D(BgfxSampler3D _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTexture3DLod(BgfxSampler3D _sampler, float3 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

int4 bgfxTexture3D(BgfxISampler3D _sampler, float3 _coord)
{
uint3 size;
_sampler.m_texture.GetDimensions(size.x, size.y, size.z);
return _sampler.m_texture.Load(int4(_coord * size, 0) );
}

uint4 bgfxTexture3D(BgfxUSampler3D _sampler, float3 _coord)
{
uint3 size;
_sampler.m_texture.GetDimensions(size.x, size.y, size.z);
return _sampler.m_texture.Load(int4(_coord * size, 0) );
}

float4 bgfxTextureCube(BgfxSamplerCube _sampler, float3 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTextureCubeBias(BgfxSamplerCube _sampler, float3 _coord, float _bias)
{
return _sampler.m_texture.SampleBias(_sampler.m_sampler, _coord, _bias);
}

float4 bgfxTextureCubeArray(BgfxSamplerCubeArray _sampler, float4 _coord)
{
return _sampler.m_texture.Sample(_sampler.m_sampler, _coord);
}

float4 bgfxTextureCubeArrayLod(BgfxSamplerCubeArray _sampler, float4 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTextureCubeLod(BgfxSamplerCube _sampler, float3 _coord, float _level)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level);
}

float4 bgfxTextureCubeGrad(BgfxSamplerCube _sampler, float3 _coord, float3 _dPdx, float3 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float2 bgfxTextureSize(BgfxSamplerCube _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxSamplerCubeArray _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxSamplerCubeShadow _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float bgfxShadowCube(BgfxSamplerCubeShadow _sampler, float4 _coord)
{
return _sampler.m_texture.SampleCmpLevelZero(_sampler.m_sampler, _coord.xyz, _coord.w);
}

float4 bgfxTexelFetch(BgfxSampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

float4 bgfxTexelFetchOffset(BgfxSampler2D _sampler, int2 _coord, int _lod, int2 _offset)
{
return _sampler.m_texture.Load(int3(_coord, _lod), _offset );
}

float2 bgfxTextureSize(BgfxSampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxISampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float2 bgfxTextureSize(BgfxUSampler2D _sampler, int _lod)
{
float2 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, numberOfMipMapLevels);
return result;
}

float4 bgfxTextureGather0(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather1(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather2(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather3(BgfxSampler2D _sampler, float2 _coord)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGatherOffset0(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset1(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset2(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGatherOffset3(BgfxSampler2D _sampler, float2 _coord, int2 _offset)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord, _offset);
}

float4 bgfxTextureGather0(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherRed(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather1(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherGreen(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather2(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherBlue(_sampler.m_sampler, _coord);
}

float4 bgfxTextureGather3(BgfxSampler2DArray _sampler, float3 _coord)
{
return _sampler.m_texture.GatherAlpha(_sampler.m_sampler, _coord);
}

int4 bgfxTexelFetch(BgfxISampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

uint4 bgfxTexelFetch(BgfxUSampler2D _sampler, int2 _coord, int _lod)
{
return _sampler.m_texture.Load(int3(_coord, _lod) );
}

float4 bgfxTexelFetch(BgfxSampler2DMS _sampler, int2 _coord, int _sampleIdx)
{
return _sampler.m_texture.Load(_coord, _sampleIdx);
}

float4 bgfxTexelFetch(BgfxSampler2DMSArray _sampler, int3 _coord, int _sampleIdx)
{
return _sampler.m_texture.Load(_coord, _sampleIdx);
}

float4 bgfxTexelFetch(BgfxSampler2DArray _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

float4 bgfxTexelFetch(BgfxSampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

int4 bgfxTexelFetch(BgfxISampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

uint4 bgfxTexelFetch(BgfxUSampler3D _sampler, int3 _coord, int _lod)
{
return _sampler.m_texture.Load(int4(_coord, _lod) );
}

float3 bgfxTextureSize(BgfxSampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxISampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float3 bgfxTextureSize(BgfxUSampler3D _sampler, int _lod)
{
float3 result;
float numberOfMipMapLevels;
_sampler.m_texture.GetDimensions(_lod, result.x, result.y, result.z, numberOfMipMapLevels);
return result;
}

float4 bgfxTexture3DGrad(BgfxSampler3D _sampler, float3 _coord, float3 _dPdx, float3 _dPdy)
{
return _sampler.m_texture.SampleGrad(_sampler.m_sampler, _coord, _dPdx, _dPdy);
}

float4 bgfxTexture3DLodOffset(BgfxSampler3D _sampler, float3 _coord, float _level, int3 _offset)
{
return _sampler.m_texture.SampleLevel(_sampler.m_sampler, _coord, _level, _offset);
}












bool2 lessThan(float2 _a, float2 _b) { return _a < _b; }
bool3 lessThan(float3 _a, float3 _b) { return _a < _b; }
bool4 lessThan(float4 _a, float4 _b) { return _a < _b; }

bool2 lessThanEqual(float2 _a, float2 _b) { return _a <= _b; }
bool3 lessThanEqual(float3 _a, float3 _b) { return _a <= _b; }
bool4 lessThanEqual(float4 _a, float4 _b) { return _a <= _b; }

bool2 greaterThan(float2 _a, float2 _b) { return _a > _b; }
bool3 greaterThan(float3 _a, float3 _b) { return _a > _b; }
bool4 greaterThan(float4 _a, float4 _b) { return _a > _b; }

bool2 greaterThanEqual(float2 _a, float2 _b) { return _a >= _b; }
bool3 greaterThanEqual(float3 _a, float3 _b) { return _a >= _b; }
bool4 greaterThanEqual(float4 _a, float4 _b) { return _a >= _b; }

bool2 notEqual(float2 _a, float2 _b) { return _a != _b; }
bool3 notEqual(float3 _a, float3 _b) { return _a != _b; }
bool4 notEqual(float4 _a, float4 _b) { return _a != _b; }

bool2 equal(float2 _a, float2 _b) { return _a == _b; }
bool3 equal(float3 _a, float3 _b) { return _a == _b; }
bool4 equal(float4 _a, float4 _b) { return _a == _b; }

float mix(float _a, float _b, float _t) { return lerp(_a, _b, _t); }
float2 mix(float2 _a, float2 _b, float2 _t) { return lerp(_a, _b, _t); }
float3 mix(float3 _a, float3 _b, float3 _t) { return lerp(_a, _b, _t); }
float4 mix(float4 _a, float4 _b, float4 _t) { return lerp(_a, _b, _t); }

float mod(float _a, float _b) { return _a - _b * floor(_a / _b); }
float2 mod(float2 _a, float2 _b) { return _a - _b * floor(_a / _b); }
float3 mod(float3 _a, float3 _b) { return _a - _b * floor(_a / _b); }
float4 mod(float4 _a, float4 _b) { return _a - _b * floor(_a / _b); }


float2 vec2_splat(float _x) { return float2(_x, _x); }
float3 vec3_splat(float _x) { return float3(_x, _x, _x); }
float4 vec4_splat(float _x) { return float4(_x, _x, _x, _x); }

uint2 uvec2_splat(uint _x) { return uint2(_x, _x); }
uint3 uvec3_splat(uint _x) { return uint3(_x, _x, _x); }
uint4 uvec4_splat(uint _x) { return uint4(_x, _x, _x, _x); }


float4x4 mtxFromRows(float4 _0, float4 _1, float4 _2, float4 _3)
{
return float4x4(_0, _1, _2, _3);
}

float4x4 mtxFromCols(float4 _0, float4 _1, float4 _2, float4 _3)
{
return transpose(float4x4(_0, _1, _2, _3) );
}

float3x3 mtxFromRows(float3 _0, float3 _1, float3 _2)
{
return float3x3(_0, _1, _2);
}

float3x3 mtxFromCols(float3 _0, float3 _1, float3 _2)
{
return transpose(float3x3(_0, _1, _2) );
}

float3x4 mtxFromRows(float4 _0, float4 _1, float4 _2)
{
return float3x4(_0, _1, _2);
}

float3 mtxGetRow(float3x3 _mtx, int _row)
{
return float3(_mtx[_row]);
}

float3 mtxGetColumn(float3x3 _mtx, int _column)
{
return float3(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column]);
}

float4 mtxGetRow(float3x4 _mtx, int _row)
{
return float4(_mtx[_row]);
}

float3 mtxGetColumn(float3x4 _mtx, int _column)
{
return float3(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column]);
}

float4 mtxGetRow(float4x4 _mtx, int _row)
{
return float4(_mtx[_row]);
}

float4 mtxGetColumn(float4x4 _mtx, int _column)
{
return float4(_mtx[0][_column], _mtx[1][_column], _mtx[2][_column], _mtx[3][_column]);
}

float mtxGetElement(float3x3 _mtx, int _column, int _row)
{
return _mtx[_row][_column];
}

float mtxGetElement(float4x4 _mtx, int _column, int _row)
{
return _mtx[_row][_column];
}

float select(bool _cond, float _true, float _false) { return _cond ? _true : _false; }
float2 select(bool _cond, float2 _true, float2 _false) { return _cond ? _true : _false; }
float3 select(bool _cond, float3 _true, float3 _false) { return _cond ? _true : _false; }
float4 select(bool _cond, float4 _true, float4 _false) { return _cond ? _true : _false; }
float2 select(bool2 _cond, float2 _true, float2 _false) { return (float2(_cond) * _true) + (float2((!_cond) ) * _false); }
float3 select(bool3 _cond, float3 _true, float3 _false) { return (float3(_cond) * _true) + (float3((!_cond) ) * _false); }
float4 select(bool4 _cond, float4 _true, float4 _false) { return (float4(_cond) * _true) + (float4((!_cond) ) * _false); }
int select(bool _cond, int _true, int _false) { return _cond ? _true : _false; }
int2 select(bool _cond, int2 _true, int2 _false) { return _cond ? _true : _false; }
int3 select(bool _cond, int3 _true, int3 _false) { return _cond ? _true : _false; }
int4 select(bool _cond, int4 _true, int4 _false) { return _cond ? _true : _false; }
int2 select(bool2 _cond, int2 _true, int2 _false) { return (int2(_cond) * _true) + (int2((!_cond) ) * _false); }
int3 select(bool3 _cond, int3 _true, int3 _false) { return (int3(_cond) * _true) + (int3((!_cond) ) * _false); }
int4 select(bool4 _cond, int4 _true, int4 _false) { return (int4(_cond) * _true) + (int4((!_cond) ) * _false); }
uint select(bool _cond, uint _true, uint _false) { return _cond ? _true : _false; }
uint2 select(bool _cond, uint2 _true, uint2 _false) { return _cond ? _true : _false; }
uint3 select(bool _cond, uint3 _true, uint3 _false) { return _cond ? _true : _false; }
uint4 select(bool _cond, uint4 _true, uint4 _false) { return _cond ? _true : _false; }
uint2 select(bool2 _cond, uint2 _true, uint2 _false) { return (uint2(_cond) * _true) + (uint2((!_cond) ) * _false); }
uint3 select(bool3 _cond, uint3 _true, uint3 _false) { return (uint3(_cond) * _true) + (uint3((!_cond) ) * _false); }
uint4 select(bool4 _cond, uint4 _true, uint4 _false) { return (uint4(_cond) * _true) + (uint4((!_cond) ) * _false); }

static float4 u_viewRect;
static float4 u_viewTexel;
static float4x4 u_view;
static float4x4 u_invView;
static float4x4 u_proj;
static float4x4 u_invProj;
static float4x4 u_viewProj;
static float4x4 u_invViewProj;
static float4x4 u_modelView;
static float4x4 u_invModelView;
static float4x4 u_modelViewProj;
static float4 u_alphaRef4;
static float4x4 u_model[1];






float4 encodeRE8(float _r)
{
float exponent = ceil(log2(_r) );
return float4(_r / exp2(exponent)
, 0.0
, 0.0
, (exponent + 128.0) / 255.0
);
}

float decodeRE8(float4 _re8)
{
float exponent = _re8.w * 255.0 - 128.0;
return _re8.x * exp2(exponent);
}

float4 encodeRGBE8(float3 _rgb)
{
float4 rgbe8;
float maxComponent = max(max(_rgb.x, _rgb.y), _rgb.z);
float exponent = ceil(log2(maxComponent) );
rgbe8.xyz = _rgb / exp2(exponent);
rgbe8.w = (exponent + 128.0) / 255.0;
return rgbe8;
}

float3 decodeRGBE8(float4 _rgbe8)
{
float exponent = _rgbe8.w * 255.0 - 128.0;
float3 rgb = _rgbe8.xyz * exp2(exponent);
return rgb;
}

float3 encodeNormalUint(float3 _normal)
{
return _normal * 0.5 + 0.5;
}

float3 decodeNormalUint(float3 _encodedNormal)
{
return _encodedNormal * 2.0 - 1.0;
}

float2 encodeNormalSphereMap(float3 _normal)
{
return normalize(_normal.xy) * sqrt(_normal.z * 0.5 + 0.5);
}

float3 decodeNormalSphereMap(float2 _encodedNormal)
{
float zz = dot(_encodedNormal, _encodedNormal) * 2.0 - 1.0;
return float3(normalize(_encodedNormal.xy) * sqrt(1.0 - zz*zz), zz);
}

float2 octahedronWrap(float2 _val)
{



return (1.0 - abs(_val.yx) )
* mix(vec2_splat(-1.0), vec2_splat(1.0), float2(greaterThanEqual(_val.xy, vec2_splat(0.0) ) ) );
}

float2 encodeNormalOctahedron(float3 _normal)
{
_normal /= abs(_normal.x) + abs(_normal.y) + abs(_normal.z);
_normal.xy = _normal.z >= 0.0 ? _normal.xy : octahedronWrap(_normal.xy);
_normal.xy = _normal.xy * 0.5 + 0.5;
return _normal.xy;
}

float3 decodeNormalOctahedron(float2 _encodedNormal)
{
_encodedNormal = _encodedNormal * 2.0 - 1.0;

float3 normal;
normal.z = 1.0 - abs(_encodedNormal.x) - abs(_encodedNormal.y);
normal.xy = normal.z >= 0.0 ? _encodedNormal.xy : octahedronWrap(_encodedNormal.xy);
return normalize(normal);
}

float3 convertRGB2XYZ(float3 _rgb)
{



float3 xyz;
xyz.x = dot(float3(0.4124564, 0.3575761, 0.1804375), _rgb);
xyz.y = dot(float3(0.2126729, 0.7151522, 0.0721750), _rgb);
xyz.z = dot(float3(0.0193339, 0.1191920, 0.9503041), _rgb);
return xyz;
}

float3 convertXYZ2RGB(float3 _xyz)
{
float3 rgb;
rgb.x = dot(float3( 3.2404542, -1.5371385, -0.4985314), _xyz);
rgb.y = dot(float3(-0.9692660, 1.8760108, 0.0415560), _xyz);
rgb.z = dot(float3( 0.0556434, -0.2040259, 1.0572252), _xyz);
return rgb;
}

float3 convertXYZ2Yxy(float3 _xyz)
{



float inv = 1.0/dot(_xyz, float3(1.0, 1.0, 1.0) );
return float3(_xyz.y, _xyz.x*inv, _xyz.y*inv);
}

float3 convertYxy2XYZ(float3 _Yxy)
{



float3 xyz;
xyz.x = _Yxy.x*_Yxy.y/_Yxy.z;
xyz.y = _Yxy.x;
xyz.z = _Yxy.x*(1.0 - _Yxy.y - _Yxy.z)/_Yxy.z;
return xyz;
}

float3 convertRGB2Yxy(float3 _rgb)
{
return convertXYZ2Yxy(convertRGB2XYZ(_rgb) );
}

float3 convertYxy2RGB(float3 _Yxy)
{
return convertXYZ2RGB(convertYxy2XYZ(_Yxy) );
}

float3 convertRGB2Yuv(float3 _rgb)
{
float3 yuv;
yuv.x = dot(_rgb, float3(0.299, 0.587, 0.114) );
yuv.y = (_rgb.x - yuv.x)*0.713 + 0.5;
yuv.z = (_rgb.z - yuv.x)*0.564 + 0.5;
return yuv;
}

float3 convertYuv2RGB(float3 _yuv)
{
float3 rgb;
rgb.x = _yuv.x + 1.403*(_yuv.y-0.5);
rgb.y = _yuv.x - 0.344*(_yuv.y-0.5) - 0.714*(_yuv.z-0.5);
rgb.z = _yuv.x + 1.773*(_yuv.z-0.5);
return rgb;
}

float3 convertRGB2YIQ(float3 _rgb)
{
float3 yiq;
yiq.x = dot(float3(0.299, 0.587, 0.114 ), _rgb);
yiq.y = dot(float3(0.595716, -0.274453, -0.321263), _rgb);
yiq.z = dot(float3(0.211456, -0.522591, 0.311135), _rgb);
return yiq;
}

float3 convertYIQ2RGB(float3 _yiq)
{
float3 rgb;
rgb.x = dot(float3(1.0, 0.9563, 0.6210), _yiq);
rgb.y = dot(float3(1.0, -0.2721, -0.6474), _yiq);
rgb.z = dot(float3(1.0, -1.1070, 1.7046), _yiq);
return rgb;
}

float3 toLinear(float3 _rgb)
{
return pow(abs(_rgb), vec3_splat(2.2) );
}

float4 toLinear(float4 _rgba)
{
return float4(toLinear(_rgba.xyz), _rgba.w);
}

float3 toLinearAccurate(float3 _rgb)
{
float3 lo = _rgb / 12.92;
float3 hi = pow( (_rgb + 0.055) / 1.055, vec3_splat(2.4) );
float3 rgb = mix(hi, lo, float3(lessThanEqual(_rgb, vec3_splat(0.04045) ) ) );
return rgb;
}

float4 toLinearAccurate(float4 _rgba)
{
return float4(toLinearAccurate(_rgba.xyz), _rgba.w);
}

float toGamma(float _r)
{
return pow(abs(_r), 1.0/2.2);
}

float3 toGamma(float3 _rgb)
{
return pow(abs(_rgb), vec3_splat(1.0/2.2) );
}

float4 toGamma(float4 _rgba)
{
return float4(toGamma(_rgba.xyz), _rgba.w);
}

float3 toGammaAccurate(float3 _rgb)
{
float3 lo = _rgb * 12.92;
float3 hi = pow(abs(_rgb), vec3_splat(1.0/2.4) ) * 1.055 - 0.055;
float3 rgb = mix(hi, lo, float3(lessThanEqual(_rgb, vec3_splat(0.0031308) ) ) );
return rgb;
}

float4 toGammaAccurate(float4 _rgba)
{
return float4(toGammaAccurate(_rgba.xyz), _rgba.w);
}

float3 toReinhard(float3 _rgb)
{
return toGamma(_rgb/(_rgb+vec3_splat(1.0) ) );
}

float4 toReinhard(float4 _rgba)
{
return float4(toReinhard(_rgba.xyz), _rgba.w);
}

float3 toFilmic(float3 _rgb)
{
_rgb = max(vec3_splat(0.0), _rgb - 0.004);
_rgb = (_rgb*(6.2*_rgb + 0.5) ) / (_rgb*(6.2*_rgb + 1.7) + 0.06);
return _rgb;
}

float4 toFilmic(float4 _rgba)
{
return float4(toFilmic(_rgba.xyz), _rgba.w);
}

float3 toAcesFilmic(float3 _rgb)
{



float aa = 2.51f;
float bb = 0.03f;
float cc = 2.43f;
float dd = 0.59f;
float ee = 0.14f;
return saturate( (_rgb*(aa*_rgb + bb) )/(_rgb*(cc*_rgb + dd) + ee) );
}

float4 toAcesFilmic(float4 _rgba)
{
return float4(toAcesFilmic(_rgba.xyz), _rgba.w);
}

float3 luma(float3 _rgb)
{
float yy = dot(float3(0.2126729, 0.7151522, 0.0721750), _rgb);
return vec3_splat(yy);
}

float4 luma(float4 _rgba)
{
return float4(luma(_rgba.xyz), _rgba.w);
}

float3 conSatBri(float3 _rgb, float3 _csb)
{
float3 rgb = _rgb * _csb.z;
rgb = mix(luma(rgb), rgb, _csb.y);
rgb = mix(vec3_splat(0.5), rgb, _csb.x);
return rgb;
}

float4 conSatBri(float4 _rgba, float3 _csb)
{
return float4(conSatBri(_rgba.xyz, _csb), _rgba.w);
}

float3 posterize(float3 _rgb, float _numColors)
{
return floor(_rgb*_numColors) / _numColors;
}

float4 posterize(float4 _rgba, float _numColors)
{
return float4(posterize(_rgba.xyz, _numColors), _rgba.w);
}

float3 sepia(float3 _rgb)
{
float3 color;
color.x = dot(_rgb, float3(0.393, 0.769, 0.189) );
color.y = dot(_rgb, float3(0.349, 0.686, 0.168) );
color.z = dot(_rgb, float3(0.272, 0.534, 0.131) );
return color;
}

float4 sepia(float4 _rgba)
{
return float4(sepia(_rgba.xyz), _rgba.w);
}

float3 blendOverlay(float3 _base, float3 _blend)
{
float3 lt = 2.0 * _base * _blend;
float3 gte = 1.0 - 2.0 * (1.0 - _base) * (1.0 - _blend);
return mix(lt, gte, step(vec3_splat(0.5), _base) );
}

float4 blendOverlay(float4 _base, float4 _blend)
{
return float4(blendOverlay(_base.xyz, _blend.xyz), _base.w);
}

float3 adjustHue(float3 _rgb, float _hue)
{
float3 yiq = convertRGB2YIQ(_rgb);
float angle = _hue + atan2(yiq.z, yiq.y);
float len = length(yiq.yz);
return convertYIQ2RGB(float3(yiq.x, len*cos(angle), len*sin(angle) ) );
}

float4 packFloatToRgba(float _value)
{



const float4 shift = float4(255 * 255 * 255, 255 * 255, 255, 1.0);
const float4 mask = float4(0, 1.0 / 255.0, 1.0 / 255.0, 1.0 / 255.0);
float4 comp = frac(_value * shift);
comp -= comp.xxyz * mask;
return comp;
}

float unpackRgbaToFloat(float4 _rgba)
{
const float4 shift = float4(1.0 / (255.0 * 255.0 * 255.0), 1.0 / (255.0 * 255.0), 1.0 / 255.0, 1.0);
return dot(_rgba, shift);
}

float2 packHalfFloat(float _value)
{
const float2 shift = float2(255, 1.0);
const float2 mask = float2(0, 1.0 / 255.0);
float2 comp = frac(_value * shift);
comp -= comp.xx * mask;
return comp;
}

float unpackHalfFloat(float2 _rg)
{
const float2 shift = float2(1.0 / 255.0, 1.0);
return dot(_rg, shift);
}

float random(float2 _uv)
{
return frac(sin(dot(_uv.xy, float2(12.9898, 78.233) ) ) * 43758.5453);
}

float3 fixCubeLookup(float3 _v, float _lod, float _topLevelCubeSize)
{



float ax = abs(_v.x);
float ay = abs(_v.y);
float az = abs(_v.z);
float vmax = max(max(ax, ay), az);
float scale = 1.0 - exp2(_lod) / _topLevelCubeSize;
if (ax != vmax) { _v.x *= scale; }
if (ay != vmax) { _v.y *= scale; }
if (az != vmax) { _v.z *= scale; }
return _v;
}

float2 texture2DBc5(BgfxSampler2D _sampler, float2 _uv)
{
return bgfxTexture2D(_sampler, _uv).xy;
}

float3x3 cofactor(float4x4 _m)
{




return float3x3(
_m[1][1]*_m[2][2]-_m[1][2]*_m[2][1],
_m[1][2]*_m[2][0]-_m[1][0]*_m[2][2],
_m[1][0]*_m[2][1]-_m[1][1]*_m[2][0],
_m[0][2]*_m[2][1]-_m[0][1]*_m[2][2],
_m[0][0]*_m[2][2]-_m[0][2]*_m[2][0],
_m[0][1]*_m[2][0]-_m[0][0]*_m[2][1],
_m[0][1]*_m[1][2]-_m[0][2]*_m[1][1],
_m[0][2]*_m[1][0]-_m[0][0]*_m[1][2],
_m[0][0]*_m[1][1]-_m[0][1]*_m[1][0]
);
}

float toClipSpaceDepth(float _depthTextureZ)
{
return _depthTextureZ;
}

float toDepthTextureZ(float _clipSpaceZ)
{
return _clipSpaceZ;
}

float toClipSpaceY(float _y)
{
return -_y;
}

float3 clipToWorld(float4x4 _invViewProj, float3 _clipPos)
{
float4 wpos = mul(_invViewProj, float4(_clipPos, 1.0));
return wpos.xyz / wpos.w;
}






























float2 s2h_getPixelCoord(float2 _fragmentCoord)
{
return _fragmentCoord;
}





























struct ContextGather
{

float2 pxCursor;

float scale;

float4 mouseInput;


float pxLeftX;

float2 pxPos;

float4 dstColor;




float4 textColor;

float4 frameFillColor;

float4 frameBorderColor;

float4 buttonColor;

float lineWidth;




int4 s2h_State;
};

struct s2h_Triangle
{
float2 A;
float2 B;
float2 C;
};


void s2h_init(out ContextGather ui);

void s2h_setCursor(inout ContextGather ui, float2 inpxLeftTop);

void s2h_deinit(inout ContextGather ui, out int4 s2h_State);

void s2h_setScale(inout ContextGather ui, float scale);


void s2h_printTxt(inout ContextGather ui, uint a, uint b, uint c, uint d, uint e, uint f);

void s2h_printSpace(inout ContextGather ui, float numberOfChars);

void s2h_printLF(inout ContextGather ui);

void s2h_printInt(inout ContextGather ui, int value);


void s2h_printHex(inout ContextGather ui, uint value);



void s2h_printFloat(inout ContextGather ui, float value);

void s2h_printCharacter(inout ContextGather ui, uint ascii);

void s2h_printDisc(inout ContextGather ui, float4 color);

void s2h_printBox(inout ContextGather ui, float4 color);


void s2h_frame(inout ContextGather ui, uint widthInCharacters);


void s2h_drawDisc(inout ContextGather ui, float2 pxCenter, float pxRadius, float4 color);


void s2h_drawCircle(inout ContextGather ui, float2 pxCenter, float pxRadius, float4 color);

void s2h_drawHalfSpace(inout ContextGather ui, float3 halfSpace, float2 visualizePoint, float4 color, float pxCircleRadius, float pxLineRadius);



void s2h_drawRectangle(inout ContextGather ui, float2 pxLeftTop, float2 pxBottomRight, float4 color);

void s2h_drawRectangleAA(inout ContextGather ui, float2 pxA, float2 pxB, float4 borderColor, float4 innerColor, float pxThickness);


void s2h_drawCrosshair(inout ContextGather ui, float2 pxCenter, float pxRadius, float4 color);


void s2h_drawLine(inout ContextGather ui, float2 pxBegin, float2 pxEnd, float4 color);


void s2h_drawArrow(inout ContextGather ui, float2 pxStart, float2 pxEnd, float4 color, float arrowHeadLength, float arrowHeadWidth);

void s2h_drawTriangle(inout ContextGather ui, s2h_Triangle tri, float4 color);

void s2h_drawSRGBRamp(inout ContextGather ui, float2 pxPos);








void s2h_coordinateSystem(inout ContextGather ui, float2 pxOrigin, float4 domain, float pxScale, float gridSize, float4 gridColor, uint flags);







bool s2h_button(inout ContextGather ui, uint widthInCharacters);




bool s2h_radioButton(inout ContextGather ui, bool checked);


bool s2h_checkBox(inout ContextGather ui, bool checked);

void s2h_progress(inout ContextGather ui, uint widthInCharacters, float fraction);

void s2h_sliderFloat(inout ContextGather ui, uint widthInCharacters, inout float value, float minValue, float maxValue);

void s2h_sliderRGB(inout ContextGather ui, uint widthInCharacters, inout float3 value);

void s2h_sliderRGBA(inout ContextGather ui, uint widthInCharacters, inout float4 value);



void s2h_tableInt(inout ContextGather ui, uint column, float4 backgroundColor, int2 sizeInCharacters, bool goRightNotDown);

void s2h_tableFloat(inout ContextGather ui, uint column, float4 backgroundColor, int2 sizeInCharacters, bool goRightNotDown);



bool s2h_tableLookupInt(uint column, uint row, out int outValue);



bool s2h_tableLookupFloat(uint column, uint row, out float outValue);

float s2h_floatLookupFloat(uint functionId, float x);



void s2h_function(inout ContextGather ui, uint functionId, float4 backgroundColor, int2 sizeInCharacters, float2 rangeX, float2 rangeY);




float3 s2h_accurateLinearToSRGB(float3 linearCol);

float3 s2h_accurateSRGBToLinear(float3 sRGBCol);



float3 s2h_indexToColor(uint index);


float3 s2h_colorRampRGB(float value);








static const uint g_miniFont[192] = {

0x00306c6cu, 0x30003860u, 0x18600000u, 0x00000006u,
0x00786c6cu, 0x7cc66c60u, 0x30306630u, 0x0000000cu,
0x00786cfeu, 0xc0cc38c0u, 0x60183c30u, 0x00000018u,
0x0030006cu, 0x78187600u, 0x6018fffcu, 0x00fc0030u,
0x003000feu, 0x0c30dc00u, 0x60183c30u, 0x00000060u,
0x0000006cu, 0xf866cc00u, 0x30306630u, 0x300030c0u,
0x0030006cu, 0x30c67600u, 0x18600000u, 0x30003080u,
0x00000000u, 0x00000000u, 0x00000000u, 0x60000000u,
0x7c307878u, 0x1cfc38fcu, 0x78780000u, 0x18006078u,
0xc670ccccu, 0x3cc060ccu, 0xcccc3030u, 0x300030ccu,
0xce300c0cu, 0x6cf8c00cu, 0xcccc3030u, 0x60fc180cu,
0xde303838u, 0xcc0cf818u, 0x787c0000u, 0xc0000c18u,
0xf630600cu, 0xfe0ccc30u, 0xcc0c0000u, 0x60001830u,
0xe630ccccu, 0x0ccccc30u, 0xcc183030u, 0x30fc3000u,
0x7cfcfc78u, 0x1e787830u, 0x78703030u, 0x18006030u,
0x00000000u, 0x00000000u, 0x00000060u, 0x00000000u,
0x7c30fc3cu, 0xf8fefe3cu, 0xcc781ee6u, 0xf0c6c638u,
0xc6786666u, 0x6c626266u, 0xcc300c66u, 0x60eee66cu,
0xdecc66c0u, 0x666868c0u, 0xcc300c6cu, 0x60fef6c6u,
0xdecc7cc0u, 0x667878c0u, 0xfc300c78u, 0x60fedec6u,
0xdefc66c0u, 0x666868ceu, 0xcc30cc6cu, 0x62d6cec6u,
0xc0cc6666u, 0x6c626066u, 0xcc30cc66u, 0x66c6c66cu,
0x78ccfc3cu, 0xf8fef03eu, 0xcc7878e6u, 0xfec6c638u,
0x00000000u, 0x00000000u, 0x00000000u, 0x00000000u,
0xfc78fc78u, 0xfcccccc6u, 0xc6ccfe78u, 0xc0781000u,
0x66cc66ccu, 0xb4ccccc6u, 0xc6ccc660u, 0x60183800u,
0x66cc66e0u, 0x30ccccc6u, 0x6ccc8c60u, 0x30186c00u,
0x7ccc7c70u, 0x30ccccd6u, 0x38781860u, 0x1818c600u,
0x60dc6c1cu, 0x30ccccfeu, 0x38303260u, 0x0c180000u,
0x607866ccu, 0x30cc78eeu, 0x6c306660u, 0x06180000u,
0xf01ce678u, 0x78fc30c6u, 0xc678fe78u, 0x02780000u,
0x00000000u, 0x00000000u, 0x00000000u, 0x000000ffu,
0x3000e000u, 0x1c003800u, 0xe0300ce0u, 0x70000000u,
0x30006000u, 0x0c006c00u, 0x60000060u, 0x30000000u,
0x18786078u, 0x0c786076u, 0x6c700c66u, 0x30ccf878u,
0x000c7cccu, 0x7cccf0ccu, 0x76300c6cu, 0x30feccccu,
0x007c66c0u, 0xccfc60ccu, 0x66300c78u, 0x30feccccu,
0x00cc66ccu, 0xccc0607cu, 0x6630cc6cu, 0x30d6ccccu,
0x0076dc78u, 0x7678f00cu, 0xe678cce6u, 0x78c6cc78u,
0x00000000u, 0x000000f8u, 0x00007800u, 0x00000000u,
0x00000000u, 0x10000000u, 0x0000001cu, 0x18e076ffu,
0x00000000u, 0x30000000u, 0x00000030u, 0x1830dcffu,
0xdc76dc7cu, 0x7cccccc6u, 0xc6ccfc30u, 0x183000ffu,
0x66cc76c0u, 0x30ccccd6u, 0x6ccc98e0u, 0x001c00ffu,
0x66cc6678u, 0x30ccccfeu, 0x38cc3030u, 0x183000ffu,
0x7c7c600cu, 0x34cc78feu, 0x6c7c6430u, 0x183000ffu,
0x600cf0f8u, 0x1876306cu, 0xc60cfc1cu, 0x18e000ffu,
0xf01e0000u, 0x00000000u, 0x00f80000u, 0x000000ffu
};




float s2h_fontSize() { return 8.0f; }






bool s2h_fontLookup(uint ascii, int2 pxPos)
{
if(uint(pxPos.x) >= 8u || uint(pxPos.y) >= 8u)
return false;

if (ascii <= 32u || ascii > 127u)
return false;


uint chr = ascii - 32u;

uint2 chrPos = uint2(chr % 16u, chr / 16u);
uint2 pixel = uint2(chrPos.x * 8u + uint(pxPos.x), chrPos.y * 8u + uint(pxPos.y));
uint dwordId = pixel.x / 32u + (pixel.y * 4u);

uint bitId = uint(pixel.x) & 0x1fu;


uint dwordValue = g_miniFont[dwordId];

return ((dwordValue >> (31u - bitId)) & 1u) != 0u;
}

void s2h_printCharacter(inout ContextGather ui, uint ascii)
{
int2 pxLocal = int2(floor((ui.pxPos - ui.pxCursor) / ui.scale));

if(s2h_fontLookup(ascii, pxLocal))
ui.dstColor = mix(ui.dstColor, float4(ui.textColor.rgb, 1), ui.textColor.a);

ui.pxCursor.x += s2h_fontSize() * ui.scale;
}


static const uint _A = 65u;
static const uint _B = 66u;
static const uint _C = 67u;
static const uint _D = 68u;
static const uint _E = 69u;
static const uint _F = 70u;
static const uint _G = 71u;
static const uint _H = 72u;
static const uint _I = 73u;
static const uint _J = 74u;
static const uint _K = 75u;
static const uint _L = 76u;
static const uint _M = 77u;
static const uint _N = 78u;
static const uint _O = 79u;
static const uint _P = 80u;
static const uint _Q = 81u;
static const uint _R = 82u;
static const uint _S = 83u;
static const uint _T = 84u;
static const uint _U = 85u;
static const uint _V = 86u;
static const uint _W = 87u;
static const uint _X = 88u;
static const uint _Y = 89u;
static const uint _Z = 90u;

static const uint _a = (_A + 32u);
static const uint _b = (_B + 32u);
static const uint _c = (_C + 32u);
static const uint _d = (_D + 32u);
static const uint _e = (_E + 32u);
static const uint _f = (_F + 32u);
static const uint _g = (_G + 32u);
static const uint _h = (_H + 32u);
static const uint _i = (_I + 32u);
static const uint _j = (_J + 32u);
static const uint _k = (_K + 32u);
static const uint _l = (_L + 32u);
static const uint _m = (_M + 32u);
static const uint _n = (_N + 32u);
static const uint _o = (_O + 32u);
static const uint _p = (_P + 32u);
static const uint _q = (_Q + 32u);
static const uint _r = (_R + 32u);
static const uint _s = (_S + 32u);
static const uint _t = (_T + 32u);
static const uint _u = (_U + 32u);
static const uint _v = (_V + 32u);
static const uint _w = (_W + 32u);
static const uint _x = (_X + 32u);
static const uint _y = (_Y + 32u);
static const uint _z = (_Z + 32u);

static const uint _SINGLEQUOTE = 39u;
static const uint _UNDERSCORE = 95u;
static const uint _MINUS = 45u;
static const uint _PLUS = 43u;
static const uint _ASTERISK = 42u;
static const uint _PERIOD = 46u;
static const uint _COLON = 58u;
static const uint _COMMA = 44u;
static const uint _SPACE = 32u;
static const uint _LESS = 60u;
static const uint _EQUAL = 61u;
static const uint _GREATER = 62u;
static const uint _SLASH = 47u;
static const uint _BACKSLASH = 92u;
static const uint _0 = 48u;
static const uint _1 = 49u;
static const uint _2 = 50u;
static const uint _3 = 51u;
static const uint _4 = 52u;
static const uint _5 = 53u;
static const uint _6 = 54u;
static const uint _7 = 55u;
static const uint _8 = 56u;
static const uint _9 = 57u;
static const int _S2H_VERSION = 14;

void s2h_init(out ContextGather ui, float2 inPxPos)
{

ui.textColor = float4(1, 1, 1, 1);
ui.pxLeftX = 0.0f;
ui.pxCursor = float2(0, 0);
ui.scale = 1.0f;
ui.mouseInput = float4(-100, -100, 0, 0);

ui.pxPos = inPxPos;

ui.dstColor = float4(0, 0, 0, 0);
ui.s2h_State = int4(0, 0, 0, 0);

ui.frameFillColor = float4(0.9f, 0.9f, 0.9f, 1);
ui.frameBorderColor = float4(0.7f, 0.7f, 0.7f, 1);
ui.buttonColor = float4(0.5f, 0.5f, 0.5f, 1);
ui.lineWidth = 2.0f;
}

void s2h_setCursor(inout ContextGather ui, float2 inpxLeftTop)
{
ui.pxCursor = inpxLeftTop;
ui.pxLeftX = inpxLeftTop.x;
}

void s2h_deinit(inout ContextGather ui, out int4 s2h_State)
{

if(ui.mouseInput.x != -100.0f && ui.mouseInput.z == 0.0f)
ui.s2h_State = int4(0,0,0,0);

s2h_State = ui.s2h_State;
}

void s2h_setScale(inout ContextGather ui, float scale)
{
ui.scale = scale;
}

void s2h_printTxt(inout ContextGather ui, uint a)
{
s2h_printCharacter(ui, a);
}

void s2h_printTxt(inout ContextGather ui, uint a, uint b)
{ s2h_printTxt(ui, a); s2h_printCharacter(ui, b); }
void s2h_printTxt(inout ContextGather ui, uint a, uint b, uint c)
{ s2h_printTxt(ui, a, b); s2h_printCharacter(ui, c); }
void s2h_printTxt(inout ContextGather ui, uint a, uint b, uint c, uint d)
{ s2h_printTxt(ui, a, b, c); s2h_printCharacter(ui, d); }
void s2h_printTxt(inout ContextGather ui, uint a, uint b, uint c, uint d, uint e)
{ s2h_printTxt(ui, a, b, c, d); s2h_printCharacter(ui, e); }
void s2h_printTxt(inout ContextGather ui, uint a, uint b, uint c, uint d, uint e, uint f)
{ s2h_printTxt(ui, a, b, c, d, e); s2h_printCharacter(ui, f); }

void s2h_printSpace(inout ContextGather ui, float numberOfChars)
{
ui.pxCursor.x += s2h_fontSize() * numberOfChars * ui.scale;
}

void s2h_printLF(inout ContextGather ui)
{
ui.pxCursor.x = ui.pxLeftX;
ui.pxCursor.y += s2h_fontSize() * ui.scale;
}

void s2h_printInt(inout ContextGather ui, int value)
{

if (value < 0)
{
s2h_printCharacter(ui, _MINUS);
value = -value;
}
if (value == 0)
{
s2h_printCharacter(ui, _0);
return;
}

{
uint tmp = uint(value);
while (tmp != 0u)
{
ui.pxCursor.x += s2h_fontSize() * ui.scale;
tmp /= 10u;
}
}

{
float backup = ui.pxCursor.x;
uint tmp = uint(value);
while (tmp != 0u)
{

uint digit = tmp % 10u;
tmp /= 10u;

ui.pxCursor.x -= s2h_fontSize() * ui.scale;
s2h_printCharacter(ui, _0 + digit);

ui.pxCursor.x -= s2h_fontSize() * ui.scale;
}
ui.pxCursor.x = backup;
}
}

void s2h_printHex(inout ContextGather ui, uint value)
{

for(int i = 7; i >= 0; --i)
{

uint nibble = (value >> (uint(i) * 4u)) & 0xfu;
uint start = (nibble < 10u) ? _0 : (_A - 10u);
s2h_printCharacter(ui, start + nibble);
}
}

void s2h_printFloat(inout ContextGather ui, float value)
{
s2h_printInt(ui, int(value));
float fractional = frac(abs(value));

s2h_printCharacter(ui, _PERIOD);

uint digitCount = 3u;




for(uint i = 0u; i < digitCount; ++i)
{
fractional *= 10.0f;

uint digit = uint(fractional);
fractional = frac(fractional);
s2h_printCharacter(ui, _0 + digit);
}
}

void s2h_printBox(inout ContextGather ui, float4 color)
{
float2 pxLocal = float2(ui.pxPos - ui.pxCursor) / float(ui.scale) - float2(4, 4);

float mask = saturate(4.0f - max(abs(pxLocal.x), abs(pxLocal.y)));


if(mask > 0.0f)
ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a);

ui.pxCursor.x += s2h_fontSize() * ui.scale;
}

void s2h_drawDisc(inout ContextGather ui, float2 pxCenter, float pxRadius, float4 color)
{
float2 pxLocal = ui.pxPos - pxCenter;

float len = length(pxLocal);
float mask = saturate(pxRadius - len);

ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a * mask);
}

void s2h_drawCircle(inout ContextGather ui, float2 pxCenter, float pxRadius, float4 color)
{
float r = ui.lineWidth * 0.5f;
float2 pxLocal = ui.pxPos - pxCenter;

float len = length(pxLocal);
float mask = saturate(pxRadius - len + r) * (1.0f - saturate(pxRadius - len - r));

ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a * mask);
}

void s2h_drawHalfSpace(inout ContextGather ui, float3 halfSpace, float2 visualizePoint, float4 color, float pxCircleRadius, float lineRadius)
{

halfSpace /= length(halfSpace.xy);


float2 onPoint = visualizePoint - halfSpace.xy * dot(halfSpace, float3(visualizePoint, 1));

float planeDist = dot(halfSpace, float3(ui.pxPos, 1));
float diskDist = length(onPoint - ui.pxPos);


float sideMask = saturate(planeDist);

float lineMask = saturate(ui.lineWidth - abs(planeDist - ui.lineWidth)) * saturate(lineRadius - diskDist);

float semiDiskMask = saturate(pxCircleRadius - diskDist) * sideMask;
float mask = max(semiDiskMask, lineMask);

ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a * mask);
}

void s2h_drawRectangle(inout ContextGather ui, float2 pxLeftTop, float2 pxBottomRight, float4 color)
{
if(ui.pxPos.x >= pxLeftTop.x && ui.pxPos.y >= pxLeftTop.y && ui.pxPos.x < pxBottomRight.x && ui.pxPos.y < pxBottomRight.y)
ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a);
}

void s2h_drawRectangleAA(inout ContextGather ui, float2 pxA, float2 pxB, float4 borderColor, float4 innerColor, float pxThickness)
{
float r = pxThickness * 0.5f;

float2 pxCenter = (pxA + pxB) * 0.5f;
float2 pxHalfSize = abs(pxB - pxA) * 0.5f;

float2 pxLocalOuter = max(abs(ui.pxPos - pxCenter) - pxHalfSize, float2(0, 0));
float2 pxLocalInner = max(abs(ui.pxPos - pxCenter) - pxHalfSize + r, float2(0, 0));

float maskOuter = saturate(1.0f + r - length(pxLocalOuter));
float maskInner = saturate(length(pxLocalInner) - 0.5f);

float4 color = mix(innerColor, float4(borderColor.rgb, 1), borderColor.a * maskInner);

ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a * maskOuter);
}

void s2h_drawCrosshair(inout ContextGather ui, float2 pxCenter, float pxRadius, float4 color)
{
float2 h = float2(pxRadius, 0);
float2 v = float2(0, pxRadius);

s2h_drawLine(ui, pxCenter - h, pxCenter + h, color);
s2h_drawLine(ui, pxCenter - v, pxCenter + v, color);
}

void s2h_drawLine(inout ContextGather ui, float2 pxBegin, float2 pxEnd, float4 color)
{
float pxThickness = ui.lineWidth + 1.0f;
float r = pxThickness * 0.5f;
float2 delta = pxEnd - pxBegin;
float len = length(delta);
if(len > 0.01f)
{
float2 tangent = delta / len;
float2 normal = float2(tangent.y, -tangent.x);
float2 local = float2(ui.pxPos) - pxBegin;
float2 uv = float2(dot(local, tangent), dot(local, normal));

float mask = saturate(r - abs(uv.y)) * saturate(r - uv.x + len) * saturate(r + uv.x);

ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a * mask);
}
}

float3 s2h_getHalfSpacePlane(float2 pointA, float2 pointB)
{
float2 pointDelta = pointA - pointB;
float2 ab = pointDelta / max(length(pointDelta), 0.0001f);
float3 abPlane = float3(-ab.y, ab.x, 0);
abPlane.z = dot(abPlane.xy, -pointA);

return abPlane;
}

void s2h_drawTriangle(inout ContextGather ui, s2h_Triangle tri, float4 color)
{
float3 abPlane = s2h_getHalfSpacePlane(tri.A, tri.B);
float abMask = saturate(dot(abPlane, float3(ui.pxPos, 1)) - 0.5f);

float3 bcPlane = s2h_getHalfSpacePlane(tri.B, tri.C);
float bcMask = saturate(dot(bcPlane, float3(ui.pxPos, 1))- 0.5f);

float3 caPlane = s2h_getHalfSpacePlane(tri.C, tri.A);
float caMask = saturate(dot(caPlane, float3(ui.pxPos, 1)) - 0.5f);

float mask = abMask * bcMask * caMask;
ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a * mask);
}

void s2h_drawArrow(inout ContextGather ui, float2 pxStart, float2 pxEnd, float4 color, float arrowHeadLength, float arrowHeadWidth)
{
float2 directionVector = pxEnd - pxStart;
float directionLength = max(length(directionVector), 0.0001f);
float2 direction = directionVector / directionLength;

float2 lineStart = pxStart;

float2 lineEnd = pxEnd - direction * arrowHeadLength;

float2 perpendicularDir = float2(direction.y, -direction.x);

s2h_drawLine(ui, lineStart, lineEnd, color);

s2h_Triangle triA;
triA.A = lineEnd - perpendicularDir * arrowHeadWidth;
triA.B = lineEnd + direction * arrowHeadLength;
triA.C = lineEnd + perpendicularDir * arrowHeadWidth;
s2h_drawTriangle(ui, triA, color);
}

void s2h_drawSRGBRamp(inout ContextGather ui, float2 pxPos)
{

pxPos = floor(pxPos) + 0.5f;

float2 local = ui.pxPos - pxPos;

float u = local.x / 256.0f;

if(local.y > 16.0f)
u = floor(u * 16.0f) / 16.0f;

float3 col = s2h_accurateSRGBToLinear(float3(u, u, u));

s2h_drawRectangle(ui, pxPos - 2.0f, pxPos + float2(256, 32) + 2.0f, float4(s2h_colorRampRGB(u), 1));
s2h_drawRectangle(ui, pxPos, pxPos + float2(256, 32), float4(col, 1));

ContextGather backup = ui;
s2h_setScale(ui, 1.0f);
ui.textColor = float4(1, 1, 1, 1);
s2h_setCursor(ui, pxPos + float2(2.0f, 22));
s2h_printTxt(ui, _0);
s2h_setCursor(ui, pxPos + float2(128.0f - 1.5f * 8.0f, 22));
s2h_printTxt(ui, _1, _2, _7);
ui.textColor = float4(0, 0, 0, 1);
s2h_setCursor(ui, pxPos + float2(256.0f - 3.2f * 8.0f, 22));
s2h_printTxt(ui, _2, _5, _5);

ui.pxCursor = backup.pxCursor;
ui.scale = backup.scale;
ui.textColor = backup.textColor;
ui.pxLeftX = backup.pxLeftX;
}

void s2h_coordinateSystem(inout ContextGather ui, float2 pxOrigin, float4 domain, float pxScale, float gridSize, float4 gridColor, uint flags)
{

pxOrigin = floor(pxOrigin);

bool yIsUp = (flags & 0x1u) != 0u;
bool gridLines = (flags & 0x2u) != 0u;

float4 color = ui.textColor;

float pxDotSize = ui.lineWidth;

float2 pxD = frac(floor(ui.pxPos - pxOrigin + pxDotSize / 2.0f) / gridSize) * gridSize;

if (gridLines)
{
if (pxD.x > floor(pxDotSize) && pxD.y > floor(pxDotSize))
gridColor = float4(0.0f, 0.0f, 0.0f, 0.0f);
}
else
{
if (pxD.x > floor(pxDotSize) || pxD.y > floor(pxDotSize))
gridColor = float4(0.0f, 0.0f, 0.0f, 0.0f);
}

float4 pxDomain = domain * pxScale + float4(pxOrigin, pxOrigin);

s2h_drawRectangle(ui, pxDomain.xy, pxDomain.zw, gridColor);

float backupLineWidth = ui.lineWidth;


if (pxD.x < backupLineWidth)
ui.lineWidth *= 2.0f;
s2h_drawArrow(ui, float2(pxDomain.x, pxOrigin.y), float2(pxDomain.z, pxOrigin.y), color, 16.0f, 8.0f);


ui.lineWidth = backupLineWidth;
if (pxD.y < backupLineWidth)
ui.lineWidth *= 2.0f;

if (yIsUp)
s2h_drawArrow(ui, float2(pxOrigin.x, pxDomain.w), float2(pxOrigin.x, pxDomain.y), color, 16.0f, 8.0f);
else
s2h_drawArrow(ui, float2(pxOrigin.x, pxDomain.y), float2(pxOrigin.x, pxDomain.w), color, 16.0f, 8.0f);

ui.lineWidth = backupLineWidth;
}

void s2h_printDisc(inout ContextGather ui, float4 color)
{
float2 pxLocal = float2(ui.pxPos - ui.pxCursor) / float(ui.scale) - float2(4, 4);

float mask = saturate(4.0f - length(pxLocal));



if(mask > 0.0f)
ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a);

ui.pxCursor.x += s2h_fontSize() * ui.scale;
}

float s2h_computeDistToBox(inout ContextGather ui, float2 p, float2 center, float2 halfSize)
{
float2 pxLocal = float2(p - center);
float2 dist2 = max(float2(0, 0), abs(pxLocal) - halfSize);
return max(dist2.x, dist2.y);
}


float s2h_computeDistToBox(inout ContextGather ui, float2 p, float4 aabb)
{
float2 center = (aabb.xy + aabb.zw) * 0.5f;
float2 halfSize = (aabb.zw - aabb.xy) * 0.5f;
float2 pxLocal = float2(p - center);
float2 dist2 = max(float2(0, 0), abs(pxLocal) - halfSize);
return max(dist2.x, dist2.y);
}

void s2h_frame(inout ContextGather ui, uint widthInCharacters)
{
float4 aabb = float4(ui.pxCursor - float2(widthInCharacters, 0) * s2h_fontSize() * ui.scale, ui.pxCursor);


aabb += float4(4, 4, -4, 4) * ui.scale;

float dist = s2h_computeDistToBox(ui, ui.pxPos, aabb) / ui.scale;

float rimMask = saturate(3.0f - dist);
float outerMask = saturate(4.0f - dist);

float4 localColor = float4(0,0,0,0);


if(outerMask > 0.0f)
localColor = ui.frameBorderColor;

if(rimMask > 0.0f)
localColor = ui.frameFillColor;

ui.dstColor = mix(ui.dstColor, float4(localColor.rgb, 1), localColor.a * (1.0f - ui.dstColor.a));
}

bool s2h_button(inout ContextGather ui, uint widthInCharacters)
{
float4 color = ui.buttonColor;
const float border = 0.0f;

float4 aabb = float4(ui.pxCursor - float2(widthInCharacters, 0) * s2h_fontSize() * ui.scale, ui.pxCursor);


aabb += float4(4, 4, -4, 4) * ui.scale;

float dist = s2h_computeDistToBox(ui, ui.pxPos, aabb) / ui.scale;
bool mouseOver = s2h_computeDistToBox(ui, ui.mouseInput.xy, aabb) / ui.scale < 5.0f + border;

float rimMask = saturate(5.0f - dist + border);
float outerMask = saturate(4.0f - dist + border);

float4 localColor = float4(0,0,0,0);

if(mouseOver && rimMask > 0.0f)
localColor = float4(1, 1, 1, 1);


if(outerMask > 0.0f)
localColor = color;

ui.dstColor = mix(ui.dstColor, float4(localColor.rgb, 1), localColor.a * (1.0f - ui.dstColor.a));

float2 delta = round(ui.mouseInput.xy + 0.5f - ui.pxPos);

return mouseOver && delta.x == 0.0f && delta.y == 0.0f;
}

bool s2h_radioButton(inout ContextGather ui, bool checked)
{
float4 color = ui.buttonColor;

float2 pxLocal = float2(ui.pxPos - ui.pxCursor - 0.5f) / float(ui.scale) - float2(3.5f, 3.5f);
float dist = length(pxLocal);

float rimMask = saturate(5.0f - dist);
float outerMask = saturate(4.0f - dist);
float innerMask = saturate(2.5f - dist);

bool mouseOver = length(float2(ui.mouseInput.xy - ui.pxCursor) / float(ui.scale) - float2(3.5f, 3.5f)) < 4.0f;

if(mouseOver && rimMask > 0.0f)
ui.dstColor = float4(1, 1, 1 ,1);


if(outerMask > 0.0f)
ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a);
if(checked && innerMask > 0.0f)
ui.dstColor = mix(ui.dstColor, float4(ui.textColor.rgb, 1), ui.textColor.a);

ui.pxCursor.x += s2h_fontSize() * ui.scale;

float2 delta = round(ui.mouseInput.xy + 0.5f - ui.pxPos);

return mouseOver && delta.x == 0.0f && delta.y == 0.0f;
}

bool s2h_checkBox(inout ContextGather ui, bool checked)
{
float4 color = ui.buttonColor;

float2 pxLocal = float2(ui.pxPos - ui.pxCursor - 0.5f) / float(ui.scale) - float2(3.5f, 3.5f);
float dist = max(abs(pxLocal.x), abs(pxLocal.y));

float rimMask = saturate(5.0f - dist);
float outerMask = saturate(4.0f - dist);
float innerMask = saturate(2.5f - dist);

bool mouseOver = length(float2(ui.mouseInput.xy - ui.pxCursor) / float(ui.scale) - float2(3.5f, 3.5f)) < 4.0f;

if(mouseOver && rimMask > 0.0f)
ui.dstColor = float4(1, 1, 1 ,1);


if(outerMask > 0.0f)
ui.dstColor = mix(ui.dstColor, float4(color.rgb, 1), color.a);
if(checked && innerMask > 0.0f)
ui.dstColor = mix(ui.dstColor, float4(ui.textColor.rgb, 1), ui.textColor.a);

ui.pxCursor.x += s2h_fontSize() * ui.scale;

float2 delta = round(ui.mouseInput.xy + 0.5f - ui.pxPos);

return mouseOver && delta.x == 0.0f && delta.y == 0.0f;
}


void s2h_progress(inout ContextGather ui, uint widthInCharacters, float fraction)
{
float4 color = ui.buttonColor;
float4 outerAABB = float4(ui.pxCursor, ui.pxCursor + float2(float(widthInCharacters) * s2h_fontSize(), s2h_fontSize() - 2.0f) * ui.scale);
outerAABB += 0.5f;


float4 innerAABB = outerAABB + float4(1, 1, -1, -1) * ui.scale;

innerAABB.z = mix(innerAABB.x, innerAABB.z, saturate(fraction));

float sliderDist = s2h_computeDistToBox(ui, ui.pxPos, outerAABB);
float innerDist = s2h_computeDistToBox(ui, ui.pxPos, innerAABB);

float4 localColor = float4(0,0,0,0);


if(sliderDist <= 0.0f)
localColor = color;

if(innerDist <= 0.0f)
localColor = mix(localColor, float4(ui.textColor.rgb, 1), ui.textColor.a);

ui.pxCursor.x += float(widthInCharacters) * s2h_fontSize() * ui.scale;

ui.dstColor = mix(ui.dstColor, float4(localColor.rgb, 1), localColor.a * (1.0f - ui.dstColor.a));
}


void s2h_sliderFloat(inout ContextGather ui, uint widthInCharacters, inout float value, float minValue, float maxValue)
{
float4 color = ui.buttonColor;
float4 outerAABB = float4(ui.pxCursor, ui.pxCursor + float2(float(widthInCharacters) * s2h_fontSize(), s2h_fontSize() - 2.0f) * ui.scale);
outerAABB += 0.5f;

float halfChar = s2h_fontSize() / 2.0f;


float4 innerAABB = outerAABB + float4(1, 1, -1, -1) * ui.scale;

float sliderDist = s2h_computeDistToBox(ui, ui.pxPos, outerAABB);


float2 currentMouse = (ui.s2h_State.x == 0 && ui.s2h_State.y == 0) ? ui.mouseInput.xy : float2(ui.s2h_State.xy);

bool mouseOver = s2h_computeDistToBox(ui, currentMouse, outerAABB) <= 0.0f;

float3 knobColor = ui.textColor.rgb;


if(mouseOver && ui.mouseInput.z != 0.0f)
{
float newFraction = saturate((ui.mouseInput.xy.x - innerAABB.x) / (innerAABB.z - innerAABB.x));
value = mix(minValue, maxValue, newFraction);

knobColor = float3(1, 1, 1);


if(ui.s2h_State.x == 0 && ui.s2h_State.y == 0)
ui.s2h_State.xy = int2(ui.mouseInput.xy);
}

float fraction = saturate((value - minValue) / (maxValue - minValue));

float knobRange = (float(widthInCharacters) - 1.0f) * s2h_fontSize() * ui.scale;
float2 knobPos = ui.pxCursor + float2(halfChar * ui.scale, 0.0f) + float2(fraction * knobRange, 3.0f * ui.scale);
float2 knobSize = float2(s2h_fontSize() - 4.0f, s2h_fontSize() - 4.0f) * 0.5f * ui.scale;
float4 knobAABB = float4(knobPos - knobSize, knobPos + knobSize);
knobAABB += 0.5f;

float knobDist = s2h_computeDistToBox(ui, ui.pxPos, knobAABB);

float4 localColor = float4(0,0,0,0);

if(mouseOver && sliderDist <= 2.0)
localColor = float4(1, 1, 1 ,1);


if(sliderDist <= 0.0f)
localColor = color;




if(knobDist <= 0.0f)
localColor = mix(localColor, float4(knobColor, 1), ui.textColor.a);

ui.pxCursor.x += float(widthInCharacters) * s2h_fontSize() * ui.scale;

ui.dstColor = mix(ui.dstColor, float4(localColor.rgb, 1), localColor.a * (1.0f - ui.dstColor.a));
}

void s2h_sliderRGB(inout ContextGather ui, uint widthInCharacters, inout float3 value)
{
float r = 3.0f * s2h_fontSize() * 0.5f * ui.scale - 1.0f;
float4 backup = ui.buttonColor;

float2 initialPos = ui.pxCursor;
float2 pos = initialPos + float2(3.0f * s2h_fontSize() * ui.scale, 0.0f);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(1,0.1f,0.1f,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.r, 0.0f, 1.0f);
s2h_printLF(ui);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(0,1,0,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.g, 0.0f, 1.0f);
s2h_printLF(ui);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(0.2f,0.2f,1,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.b, 0.0f, 1.0f);
s2h_printLF(ui);



s2h_drawDisc(ui, initialPos + r, r, float4(value, 1));

ui.pxCursor = initialPos + float2(float(widthInCharacters) * s2h_fontSize() * ui.scale, 0.0f);

ui.buttonColor = backup;
}

void s2h_sliderRGBA(inout ContextGather ui, uint widthInCharacters, inout float4 value)
{
float r = 3.0f * s2h_fontSize() * 0.5f * ui.scale - 1.0f;
float4 backup = ui.buttonColor;

float2 initialPos = ui.pxCursor;
float2 pos = initialPos + float2(3.0f * s2h_fontSize() * ui.scale, 0.0f);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(1,0.1f,0.1f,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.r, 0.0f, 1.0f);
s2h_printLF(ui);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(0,1,0,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.g, 0.0f, 1.0f);
s2h_printLF(ui);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(0.2f,0.2f,1,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.b, 0.0f, 1.0f);
s2h_printLF(ui);

ui.pxCursor.x = pos.x;
ui.buttonColor = float4(0.5f,0.5f,0.5f,1);
s2h_sliderFloat(ui, widthInCharacters - 3u, value.a, 0.0f, 1.0f);
s2h_printLF(ui);



s2h_drawDisc(ui, initialPos + r, r, value);

ui.pxCursor = initialPos + float2(float(widthInCharacters) * s2h_fontSize() * ui.scale, 0.0f);

ui.buttonColor = backup;
}

void s2h_tableInt(inout ContextGather ui, uint column, float4 backgroundColor, int2 sizeInCharacters, bool goRightNotDown)
{
float pxCharSize = s2h_fontSize() * ui.scale;
float2 backup = ui.pxCursor;
float2 localPos = ui.pxPos - ui.pxCursor;
float2 pxSize = float2(sizeInCharacters) * pxCharSize;

if(localPos.x >= 0.0f && localPos.y >= 0.0f && localPos.x < pxSize.x && localPos.y < pxSize.y)
{
ui.dstColor = mix(ui.dstColor, float4(backgroundColor.rgb, 1), backgroundColor.a * (1.0f - ui.dstColor.a));

int row = int(localPos.y / pxCharSize);

ui.pxCursor.y = backup.y + floor(localPos.y / pxCharSize) * pxCharSize;

int value = 0;
if(s2h_tableLookupInt(column, row, value))
{
s2h_printInt(ui, value);
}
}
if(goRightNotDown)
{
ui.pxCursor.x = backup.x + pxSize.x;
}
else
{
s2h_printLF(ui);
ui.pxCursor.y = backup.y + pxSize.y;
}
}

void s2h_tableFloat(inout ContextGather ui, uint column, float4 backgroundColor, int2 sizeInCharacters, bool goRightNotDown)
{
float pxCharSize = s2h_fontSize() * ui.scale;
float2 backup = ui.pxCursor;
float2 localPos = ui.pxPos - ui.pxCursor;
float2 pxSize = float2(sizeInCharacters) * pxCharSize;

if(localPos.x >= 0.0f && localPos.y >= 0.0f && localPos.x < pxSize.x && localPos.y < pxSize.y)
{
ui.dstColor = mix(ui.dstColor, float4(backgroundColor.rgb, 1), backgroundColor.a * (1.0f - ui.dstColor.a));

int row = int(localPos.y / pxCharSize);

ui.pxCursor.y = backup.y + floor(localPos.y / pxCharSize) * pxCharSize;

float value = 0.0f;
if(s2h_tableLookupFloat(column, row, value))
{
s2h_printFloat(ui, value);
}
}
if(goRightNotDown)
{
ui.pxCursor.x = backup.x + pxSize.x;
}
else
{
s2h_printLF(ui);
ui.pxCursor.y = backup.y + pxSize.y;
}
}

void s2h_function(inout ContextGather ui, uint functionId, float4 backgroundColor, int2 sizeInCharacters, float2 rangeX, float2 rangeY)
{
float scaledFontSize = s2h_fontSize() * ui.scale;

float2 backup = ui.pxCursor;
float2 localPos = ui.pxPos - ui.pxCursor;
float2 pxSize = float2(sizeInCharacters) * scaledFontSize;

if(localPos.x >= 0.0f && localPos.y >= 0.0f && localPos.x < pxSize.x && localPos.y < pxSize.y)
{

float x = mix(rangeX.x, rangeX.y, localPos.x / pxSize.x);

ui.dstColor = mix(ui.dstColor, float4(backgroundColor.rgb, 1), backgroundColor.a * (1.0f - ui.dstColor.a));

int row = int(localPos.y / scaledFontSize);

ui.pxCursor.y = backup.y + floor(localPos.y / scaledFontSize) * scaledFontSize;


float y = s2h_floatLookupFloat(functionId, x);

float pxY = (1.0f - (y - rangeY.x) / (rangeY.y - rangeY.x)) * pxSize.y;

if(pxY < localPos.y)
ui.dstColor = mix(ui.dstColor, float4(ui.textColor.rgb, 1), ui.textColor.a);
}

s2h_printLF(ui);
ui.pxCursor.y = backup.y + pxSize.y;
}
float3 s2h_accurateLinearToSRGB(float3 linearCol)
{
float3 sRGBLo = linearCol * 12.92;
float3 sRGBHi = (pow(abs(linearCol), float3(1.0 / 2.4, 1.0 / 2.4, 1.0 / 2.4)) * 1.055) - 0.055;
float3 sRGB;
sRGB.r = linearCol.r <= 0.0031308 ? sRGBLo.r : sRGBHi.r;
sRGB.g = linearCol.g <= 0.0031308 ? sRGBLo.g : sRGBHi.g;
sRGB.b = linearCol.b <= 0.0031308 ? sRGBLo.b : sRGBHi.b;
return sRGB;
}

float3 s2h_accurateSRGBToLinear(float3 sRGBCol)
{
float3 linearRGBLo = sRGBCol / 12.92;
float3 linearRGBHi = pow((sRGBCol + 0.055) / 1.055, float3(2.4, 2.4, 2.4));
float3 linearRGB;
linearRGB.r = sRGBCol.r <= 0.04045 ? linearRGBLo.r : linearRGBHi.r;
linearRGB.g = sRGBCol.g <= 0.04045 ? linearRGBLo.g : linearRGBHi.g;
linearRGB.b = sRGBCol.b <= 0.04045 ? linearRGBLo.b : linearRGBHi.b;
return linearRGB;
}

float3 s2h_indexToColor(uint index)
{
uint a = (index >> 0u) & 1u;
uint d = (index >> 1u) & 1u;
uint g = (index >> 2u) & 1u;

uint b = (index >> 3u) & 1u;
uint e = (index >> 4u) & 1u;
uint h = (index >> 5u) & 1u;

uint c = (index >> 6u) & 1u;
uint f = (index >> 7u) & 1u;
uint i = (index >> 8u) & 1u;

return float3(a * 4u + b * 2u + c, d * 4u + e * 2u + f, g * 4u + h * 2u + i) / 7.0f;
}

float3 s2h_colorRampRGB(float value)
{
return float3(
saturate(1.0f - abs(value) * 2.0f),
saturate(1.0f - abs(value - 0.5f) * 2.0f),
saturate(1.0f - abs(value - 1.0f) * 2.0f));
}



uniform float4 u_s2hTime;
uniform float4 u_s2hUiState;
uniform float4 u_s2hColor;
uniform float4 u_s2hMouse;

void printDiscEx(inout ContextGather _ui, float4 _color)
{
s2h_printDisc(_ui, _color);
s2h_printTxt(_ui, _SPACE);
s2h_printInt(_ui, int(_color.r * 255.9f));
s2h_printTxt(_ui, _COMMA);
s2h_printInt(_ui, int(_color.g * 255.9f));
s2h_printTxt(_ui, _COMMA);
s2h_printInt(_ui, int(_color.b * 255.9f));
}

void main( float4 gl_FragCoord : SV_POSITION , float4 v_color0 : COLOR0 , float2 v_texcoord0 : TEXCOORD0 , out float4 bgfx_FragData0 : SV_TARGET0 )
{
float4 bgfx_VoidFrag = vec4_splat(0.0);

ContextGather ui;
s2h_init(ui, s2h_getPixelCoord(gl_FragCoord.xy));
ui.mouseInput = u_s2hMouse;
s2h_setCursor(ui, float2(10.0f, 10.0f));

ui.textColor.rgb = float3(1.0f, 1.0f, 1.0f);
s2h_setScale(ui, 3.0f);
s2h_printTxt(ui, _G, _a, _t, _h, _e, _r);
s2h_printTxt(ui, _T, _e, _s, _t);
s2h_printLF(ui);
s2h_printLF(ui);

ui.textColor.rgb = float3(0.0f, 0.0f, 0.0f);
s2h_setScale(ui, 2.0f);
s2h_printTxt(ui, _P, _i, _x, _e, _l, _EQUAL);
s2h_printTxt(ui, _T, _h, _r, _e, _a, _d);
s2h_setScale(ui, 3.0f);
s2h_printLF(ui);

s2h_setScale(ui, 1.0f);
ui.textColor.rgb = float3(1.0f, 0.0f, 0.0f); s2h_printTxt(ui, _R);
ui.textColor.rgb = float3(0.0f, 1.0f, 0.0f); s2h_printTxt(ui, _G);
ui.textColor.rgb = float3(0.0f, 0.0f, 1.0f); s2h_printTxt(ui, _B);
s2h_printTxt(ui, _SPACE);
ui.textColor.rgb = float3(0.0f, 0.0f, 0.0f);
s2h_printTxt(ui, _X, _Y, _Z, _COLON);
s2h_printLF(ui);
s2h_printInt(ui, 12345);
s2h_printLF(ui);
s2h_printInt(ui, -12345);
s2h_printLF(ui);
s2h_printHex(ui, 0x1297ABu);
s2h_printLF(ui);
s2h_printLF(ui);

s2h_setScale(ui, 2.0f);
s2h_printFloat(ui, -12.34f);
s2h_printTxt(ui, _COMMA);
s2h_printFloat(ui, 0.34f);
s2h_printLF(ui);
s2h_printBox(ui, float4(1.0f, 0.7f, 0.3f, 1.0f));
s2h_printBox(ui, float4(1.0f, 0.0f, 0.0f, 1.0f));
s2h_printDisc(ui, float4(0.0f, 1.0f, 0.0f, 1.0f));
s2h_printDisc(ui, float4(1.0f, 1.0f, 0.0f, 1.0f));

uint radioState = uint(u_s2hUiState.x);
uint checkboxState = uint(u_s2hUiState.y);
float sliderAlpha = u_s2hUiState.z;
float3 sliderColor = u_s2hColor.rgb;

s2h_setScale(ui, 2.0f);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _U, _I, _S, _t, _a, _t);
s2h_printTxt(ui, _e, _COLON, _SPACE, _LESS, _MINUS, _MINUS);
s2h_printTxt(ui, _SPACE, _T, _o, _u, _c, _h);
s2h_printTxt(ui, _SPACE, _M, _e);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _SPACE, _SPACE);
s2h_printInt(ui, int(radioState));
s2h_printTxt(ui, _SPACE, _EQUAL, _SPACE);
float4 buttonColor = ui.buttonColor;
ui.buttonColor = float4(1.0f, 0.0f, 0.0f, 1.0f); s2h_radioButton(ui, radioState == 1u);
ui.buttonColor = float4(0.0f, 1.0f, 0.0f, 1.0f); s2h_radioButton(ui, radioState == 2u);
ui.buttonColor = float4(0.0f, 0.0f, 1.0f, 1.0f); s2h_radioButton(ui, radioState == 3u);
ui.buttonColor = buttonColor;
s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE, _r);
s2h_printTxt(ui, _a, _d, _i, _o, _B, _u);
s2h_printTxt(ui, _t, _t, _o, _n);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _SPACE, _SPACE);
s2h_printInt(ui, int(radioState));
s2h_printTxt(ui, _SPACE, _EQUAL, _SPACE);
s2h_printTxt(ui, _C, _l, _e, _a, _r);
s2h_button(ui, 5u);
s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE, _b);
s2h_printTxt(ui, _u, _t, _t, _o, _n);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _SPACE, _SPACE);
s2h_printInt(ui, int(checkboxState));
s2h_printTxt(ui, _SPACE, _EQUAL, _SPACE);
s2h_checkBox(ui, checkboxState != 0u);
s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE, _c);
s2h_printTxt(ui, _h, _e, _c, _k, _B, _o);
s2h_printTxt(ui, _x);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _SPACE, _SPACE);
s2h_progress(ui, 5u, frac(u_s2hTime.x));
s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE, _p);
s2h_printTxt(ui, _r, _o, _g, _r, _e, _s);
s2h_printTxt(ui, _s);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _SPACE, _SPACE);
s2h_sliderFloat(ui, 8u, sliderAlpha, 0.0f, 1.0f);
s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE, _s);
s2h_printTxt(ui, _l, _i, _d, _e, _r, _F);
s2h_printTxt(ui, _l, _o, _a, _t);
s2h_printLF(ui);
s2h_printLF(ui);
s2h_printTxt(ui, _SPACE, _SPACE);
s2h_sliderRGB(ui, 8u, sliderColor);
s2h_printTxt(ui, _SPACE, _s, _2, _h, _UNDERSCORE, _s);
s2h_printTxt(ui, _l, _i, _d, _e, _r, _R);
s2h_printTxt(ui, _G, _B);

float4 background = float4(0.4f, 0.7f, 0.4f, 1.0f);
bgfx_FragData0 = mix(background, float4(ui.dstColor.rgb, 1.0f), ui.dstColor.a);
}

