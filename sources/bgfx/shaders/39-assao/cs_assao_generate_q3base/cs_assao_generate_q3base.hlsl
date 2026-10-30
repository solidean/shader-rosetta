






















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
































float4 imageLoad(Texture2D<float> _image, int2 _uv) { return _image[_uv].xxxx; } int2 imageSize(Texture2D<float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<float> _image, int2 _uv) { return _image[_uv].xxxx; } void imageStore(RWTexture2D<float> _image, int2 _uv, float4 _value) { _image[_uv] = _value.x; } int2 imageSize(RWTexture2D<float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture2DArray<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture2DArray<float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture2DArray<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture3D<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture3D<float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture3D<float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<float2> _image, int2 _uv) { return _image[_uv].xyyy; } int2 imageSize(Texture2D<float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<float2> _image, int2 _uv) { return _image[_uv].xyyy; } void imageStore(RWTexture2D<float2> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xy; } int2 imageSize(RWTexture2D<float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture2DArray<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture2DArray<float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture2DArray<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture3D<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture3D<float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture3D<float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<float4> _image, int2 _uv) { return _image[_uv].xyzw; } int2 imageSize(Texture2D<float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<float4> _image, int2 _uv) { return _image[_uv].xyzw; } void imageStore(RWTexture2D<float4> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xyzw; } int2 imageSize(RWTexture2D<float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture2DArray<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture2DArray<float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture2DArray<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture3D<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture3D<float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture3D<float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }

uint4 imageLoad(Texture2D<uint> _image, int2 _uv) { return _image[_uv].xxxx; } int2 imageSize(Texture2D<uint> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(RWTexture2D<uint> _image, int2 _uv) { return _image[_uv].xxxx; } void imageStore(RWTexture2D<uint> _image, int2 _uv, uint4 _value) { _image[_uv] = _value.x; } int2 imageSize(RWTexture2D<uint> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(Texture2DArray<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture2DArray<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture2DArray<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture2DArray<uint> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture2DArray<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(Texture3D<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture3D<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture3D<uint> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture3D<uint> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture3D<uint> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
uint4 imageLoad(Texture2D<uint2> _image, int2 _uv) { return _image[_uv].xyyy; } int2 imageSize(Texture2D<uint2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(RWTexture2D<uint2> _image, int2 _uv) { return _image[_uv].xyyy; } void imageStore(RWTexture2D<uint2> _image, int2 _uv, uint4 _value) { _image[_uv] = _value.xy; } int2 imageSize(RWTexture2D<uint2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(Texture2DArray<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture2DArray<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture2DArray<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture2DArray<uint2> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture2DArray<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(Texture3D<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture3D<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture3D<uint2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture3D<uint2> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture3D<uint2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
uint4 imageLoad(Texture2D<uint4> _image, int2 _uv) { return _image[_uv].xyzw; } int2 imageSize(Texture2D<uint4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(RWTexture2D<uint4> _image, int2 _uv) { return _image[_uv].xyzw; } void imageStore(RWTexture2D<uint4> _image, int2 _uv, uint4 _value) { _image[_uv] = _value.xyzw; } int2 imageSize(RWTexture2D<uint4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } uint4 imageLoad(Texture2DArray<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture2DArray<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture2DArray<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture2DArray<uint4> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture2DArray<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(Texture3D<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture3D<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } uint4 imageLoad(RWTexture3D<uint4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture3D<uint4> _image, int3 _uvw, uint4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture3D<uint4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }

float4 imageLoad(Texture2D<unorm float> _image, int2 _uv) { return _image[_uv].xxxx; } int2 imageSize(Texture2D<unorm float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<unorm float> _image, int2 _uv) { return _image[_uv].xxxx; } void imageStore(RWTexture2D<unorm float> _image, int2 _uv, float4 _value) { _image[_uv] = _value.x; } int2 imageSize(RWTexture2D<unorm float> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture2DArray<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture2DArray<unorm float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture2DArray<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } int3 imageSize(Texture3D<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<unorm float> _image, int3 _uvw) { return _image[_uvw].xxxx; } void imageStore(RWTexture3D<unorm float> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.x; } int3 imageSize(RWTexture3D<unorm float> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<unorm float2> _image, int2 _uv) { return _image[_uv].xyyy; } int2 imageSize(Texture2D<unorm float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<unorm float2> _image, int2 _uv) { return _image[_uv].xyyy; } void imageStore(RWTexture2D<unorm float2> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xy; } int2 imageSize(RWTexture2D<unorm float2> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture2DArray<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture2DArray<unorm float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture2DArray<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } int3 imageSize(Texture3D<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<unorm float2> _image, int3 _uvw) { return _image[_uvw].xyyy; } void imageStore(RWTexture3D<unorm float2> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xy; } int3 imageSize(RWTexture3D<unorm float2> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }
float4 imageLoad(Texture2D<unorm float4> _image, int2 _uv) { return _image[_uv].xyzw; } int2 imageSize(Texture2D<unorm float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(RWTexture2D<unorm float4> _image, int2 _uv) { return _image[_uv].xyzw; } void imageStore(RWTexture2D<unorm float4> _image, int2 _uv, float4 _value) { _image[_uv] = _value.xyzw; } int2 imageSize(RWTexture2D<unorm float4> _image) { uint2 result; _image.GetDimensions(result.x, result.y); return int2(result); } float4 imageLoad(Texture2DArray<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture2DArray<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture2DArray<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture2DArray<unorm float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture2DArray<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(Texture3D<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } int3 imageSize(Texture3D<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); } float4 imageLoad(RWTexture3D<unorm float4> _image, int3 _uvw) { return _image[_uvw].xyzw; } void imageStore(RWTexture3D<unorm float4> _image, int3 _uvw, float4 _value) { _image[_uvw] = _value.xyzw; } int3 imageSize(RWTexture3D<unorm float4> _image) { uint3 result; _image.GetDimensions(result.x, result.y, result.z); return int3(result); }

void imageAtomicAdd(RWTexture2D<uint> _image, int2 _uv, uint4 _value) { InterlockedAdd(_image[_uv], _value.x); }





static float4 bgfx_numWorkGroups;




static float4 bgfx_indirectArgBase;



uniform float4 u_params[19];
uniform float4 u_rect;







static const float4 g_samplePatternMain[(32)] =
{
{ 0.78488064, 0.56661671, 1.500000, -0.126083}, { 0.26022232, -0.29575172, 1.500000, -1.064030}, { 0.10459357, 0.08372527, 1.110000, -2.730563}, {-0.68286800, 0.04963045, 1.090000, -0.498827},
{-0.13570161, -0.64190155, 1.250000, -0.532765}, {-0.26193795, -0.08205118, 0.670000, -1.783245}, {-0.61177456, 0.66664219, 0.710000, -0.044234}, { 0.43675563, 0.25119025, 0.610000, -1.167283},
{ 0.07884444, 0.86618668, 0.640000, -0.459002}, {-0.12790935, -0.29869005, 0.600000, -1.729424}, {-0.04031125, 0.02413622, 0.600000, -4.792042}, { 0.16201244, -0.52851415, 0.790000, -1.067055},
{-0.70991218, 0.47301072, 0.640000, -0.335236}, { 0.03277707, -0.22349690, 0.600000, -1.982384}, { 0.68921727, 0.36800742, 0.630000, -0.266718}, { 0.29251814, 0.37775412, 0.610000, -1.422520},
{-0.12224089, 0.96582592, 0.600000, -0.426142}, { 0.11071457, -0.16131058, 0.600000, -2.165947}, { 0.46562141, -0.59747696, 0.600000, -0.189760}, {-0.51548797, 0.11804193, 0.600000, -1.246800},
{ 0.89141309, -0.42090443, 0.600000, 0.028192}, {-0.32402530, -0.01591529, 0.600000, -1.543018}, { 0.60771245, 0.41635221, 0.600000, -0.605411}, { 0.02379565, -0.08239821, 0.600000, -3.809046},
{ 0.48951152, -0.23657045, 0.600000, -1.189011}, {-0.17611565, -0.81696892, 0.600000, -0.513724}, {-0.33930185, -0.20732205, 0.600000, -1.698047}, {-0.91974425, 0.05403209, 0.600000, 0.062246},
{-0.15064627, -0.14949332, 0.600000, -1.896062}, { 0.53180975, -0.35210401, 0.600000, -0.758838}, { 0.41487166, 0.81442589, 0.600000, -0.505648}, {-0.24106961, -0.32721516, 0.600000, -1.665244}
};



static const uint g_numTaps[5] = { 3, 5, 12, 0, 0 };






















uniform SamplerState s_viewspaceDepthSourceSampler : register(s0); uniform Texture2D s_viewspaceDepthSourceTexture : register(t0); static BgfxSampler2D s_viewspaceDepthSource = {s_viewspaceDepthSourceSampler,s_viewspaceDepthSourceTexture };
uniform SamplerState s_viewspaceDepthSourceMirrorSampler : register(s1); uniform Texture2D s_viewspaceDepthSourceMirrorTexture : register(t1); static BgfxSampler2D s_viewspaceDepthSourceMirror = {s_viewspaceDepthSourceMirrorSampler,s_viewspaceDepthSourceMirrorTexture };
Texture2D<unorm float4> s_normalmapSource : register(t2);;
Buffer<uint> s_loadCounter : register(t3);
uniform SamplerState s_importanceMapSampler : register(s4); uniform Texture2D s_importanceMapTexture : register(t4); static BgfxSampler2D s_importanceMap = {s_importanceMapSampler,s_importanceMapTexture };
Texture2DArray<unorm float2> s_baseSSAO : register(t5);;
RWTexture2DArray<unorm float2> s_target : register(u6);;


float PackEdges( float4 edgesLRTB )
{




edgesLRTB = round( saturate( edgesLRTB ) * 3.05 );
return dot( edgesLRTB, float4( 64.0 / 255.0, 16.0 / 255.0, 4.0 / 255.0, 1.0 / 255.0 ) ) ;
}

float3 NDCToViewspace( float2 pos, float viewspaceDepth )
{
float3 ret;

ret.xy = (u_params[2].xy * pos.xy + u_params[2].zw) * viewspaceDepth;

ret.z = viewspaceDepth;

return ret;
}


void CalculateRadiusParameters( const float pixCenterLength, const float2 pixelDirRBViewspaceSizeAtCenterZ, out float pixLookupRadiusMod, out float effectRadius, out float falloffCalcMulSq )
{
effectRadius = u_params[5].x;





const float tooCloseLimitMod = saturate( pixCenterLength * u_params[6].w ) * 0.8 + 0.2;

effectRadius *= tooCloseLimitMod;


pixLookupRadiusMod = (0.85 * effectRadius) / pixelDirRBViewspaceSizeAtCenterZ.x;


falloffCalcMulSq= -1.0f / (effectRadius*effectRadius);
}

float4 CalculateEdges( const float centerZ, const float leftZ, const float rightZ, const float topZ, const float bottomZ )
{

float4 edgesLRTB = float4( leftZ, rightZ, topZ, bottomZ ) - centerZ;
float4 edgesLRTBSlopeAdjusted = edgesLRTB + edgesLRTB.yxwz;
edgesLRTB = min( abs( edgesLRTB ), abs( edgesLRTBSlopeAdjusted ) );
return saturate( ( 1.3 - edgesLRTB / (centerZ * 0.040) ) );




}

float3 DecodeNormal( float3 encodedNormal )
{
float3 normal = encodedNormal * u_params[14].x.xxx + u_params[14].y.xxx;

normal = float3( dot(normal, u_params[15].xyz),
dot(normal, u_params[16].xyz),
dot(normal, u_params[17].xyz));




return normal;
}

float3 LoadNormal( int2 pos )
{
float3 encodedNormal = imageLoad(s_normalmapSource, pos).xyz;
return DecodeNormal( encodedNormal );
}

float3 LoadNormal( int2 pos, int2 offset )
{
float3 encodedNormal = imageLoad(s_normalmapSource, pos + offset ).xyz;
return DecodeNormal( encodedNormal );
}


float CalculatePixelObscurance( float3 pixelNormal, float3 hitDelta, float falloffCalcMulSq )
{
float lengthSq = dot( hitDelta, hitDelta );
float NdotD = dot(pixelNormal, hitDelta) / sqrt(lengthSq);

float falloffMult = max( 0.0, lengthSq * falloffCalcMulSq + 1.0 );

return max( 0, NdotD - u_params[6].z ) * falloffMult;
}

void SSAOTapInner( const int qualityLevel, inout float obscuranceSum, inout float weightSum, const float2 samplingUV, const float mipLevel, const float3 pixCenterPos, const float3 negViewspaceDir,float3 pixelNormal, const float falloffCalcMulSq, const float weightMod, const int dbgTapIndex)
{

float viewspaceSampleZ = bgfxTexture2DLod(s_viewspaceDepthSource, samplingUV.xy, mipLevel).x;


float3 hitPos = NDCToViewspace( samplingUV.xy, viewspaceSampleZ ).xyz;
float3 hitDelta = hitPos - pixCenterPos;

float obscurance = CalculatePixelObscurance( pixelNormal, hitDelta, falloffCalcMulSq );
float weight = 1.0;

if( qualityLevel >= (1) )
{

float reduct = max( 0, -hitDelta.z );
reduct = saturate( reduct * u_params[7].y + 2.0 );
weight = (0.6) * reduct + (1.0 - (0.6));
}
weight *= weightMod;
obscuranceSum += obscurance * weight;
weightSum += weight;
}

void SSAOTap( const int qualityLevel, inout float obscuranceSum, inout float weightSum, const int tapIndex, const float2x2 rotScale, const float3 pixCenterPos, const float3 negViewspaceDir, float3 pixelNormal, const float2 normalizedScreenPos, const float mipOffset, const float falloffCalcMulSq, float weightMod, float2 normXY, float normXYLength)
{
float2 sampleOffset;
float samplePow2Len;


{
float4 newSample = g_samplePatternMain[tapIndex];
sampleOffset = mul(rotScale, newSample.xy);
samplePow2Len = newSample.w;
weightMod *= newSample.z;
}


sampleOffset = round(sampleOffset);



float mipLevel = ( qualityLevel < (2) )?(0):(samplePow2Len + mipOffset);

float2 samplingUV = sampleOffset * u_params[4].xy + normalizedScreenPos;

SSAOTapInner( qualityLevel, obscuranceSum, weightSum, samplingUV, mipLevel, pixCenterPos, negViewspaceDir, pixelNormal, falloffCalcMulSq, weightMod, tapIndex * 2);


float2 sampleOffsetMirroredUV = -sampleOffset;



if( qualityLevel >= (99) )
{
float dotNorm = dot( sampleOffsetMirroredUV, normXY );
sampleOffsetMirroredUV -= dotNorm * normXYLength * normXY;
sampleOffsetMirroredUV = round(sampleOffsetMirroredUV);
}


float2 samplingMirroredUV = sampleOffsetMirroredUV * u_params[4].xy + normalizedScreenPos;

SSAOTapInner( qualityLevel, obscuranceSum, weightSum, samplingMirroredUV, mipLevel, pixCenterPos, negViewspaceDir, pixelNormal, falloffCalcMulSq, weightMod, tapIndex * 2 + 1);
}


void GenerateSSAOShadowsInternal( out float outShadowTerm, out float4 outEdges, out float outWeight,
const float2 SVPos, const int qualityLevel, bool adaptiveBase)
{
float2 SVPosRounded = trunc( SVPos );
uint2 SVPosui = uint2( SVPosRounded );

const uint numberOfTaps = (adaptiveBase)?(5) : ( g_numTaps[qualityLevel] );
float pixZ, pixLZ, pixTZ, pixRZ, pixBZ;

float4 valuesUL = bgfxTextureGather0(s_viewspaceDepthSourceMirror, SVPosRounded * u_params[0].zw);
float4 valuesBR = bgfxTextureGatherOffset0(s_viewspaceDepthSourceMirror, SVPosRounded * u_params[0].zw, int2( 1, 1 ));


pixZ = valuesUL.y;


pixLZ = valuesUL.x;
pixTZ = valuesUL.z;
pixRZ = valuesBR.z;
pixBZ = valuesBR.x;

float2 normalizedScreenPos = SVPosRounded * u_params[4].xy + u_params[4].zw;
float3 pixCenterPos = NDCToViewspace( normalizedScreenPos, pixZ );


uint2 fullResCoord = uint2(SVPosui * 2 + u_params[3].xy.xy);
float3 pixelNormal = LoadNormal( int2(fullResCoord) );

const float2 pixelDirRBViewspaceSizeAtCenterZ = pixCenterPos.z * u_params[2].xy * u_params[4].xy;

float pixLookupRadiusMod;
float falloffCalcMulSq;


float effectViewspaceRadius;
CalculateRadiusParameters( length( pixCenterPos ), pixelDirRBViewspaceSizeAtCenterZ, pixLookupRadiusMod, effectViewspaceRadius, falloffCalcMulSq );


float2x2 rotScale;
{

if( !adaptiveBase && (qualityLevel >= (99)) )
{
float nearScreenBorder = min( min( normalizedScreenPos.x, 1.0 - normalizedScreenPos.x ), min( normalizedScreenPos.y, 1.0 - normalizedScreenPos.y ) );
nearScreenBorder = saturate( 10.0 * nearScreenBorder + 0.6 );
pixLookupRadiusMod *= nearScreenBorder;
}


uint pseudoRandomIndex = uint( SVPosRounded.y * 2 + SVPosRounded.x ) % 5;
float4 rs = u_params[9+(pseudoRandomIndex)];
rotScale = float2x2( rs.x * pixLookupRadiusMod, rs.y * pixLookupRadiusMod, rs.z * pixLookupRadiusMod, rs.w * pixLookupRadiusMod );
}


float obscuranceSum = 0.0;
float weightSum = 0.0;


float4 edgesLRTB = float4( 1.0, 1.0, 1.0, 1.0 );


pixCenterPos *= u_params[7].x;

if( !adaptiveBase && (qualityLevel >= (1)) )
{
edgesLRTB = CalculateEdges( pixZ, pixLZ, pixRZ, pixTZ, pixBZ );
}


if( !adaptiveBase && (qualityLevel >= (1)) )
{

if( qualityLevel != 4 )
{

float3 viewspaceDirZNormalized = float3( pixCenterPos.xy / pixCenterPos.zz, 1.0 );
float3 pixLDelta = float3( -pixelDirRBViewspaceSizeAtCenterZ.x, 0.0, 0.0 ) + viewspaceDirZNormalized * (pixLZ - pixCenterPos.z);
float3 pixRDelta = float3( +pixelDirRBViewspaceSizeAtCenterZ.x, 0.0, 0.0 ) + viewspaceDirZNormalized * (pixRZ - pixCenterPos.z);
float3 pixTDelta = float3( 0.0, -pixelDirRBViewspaceSizeAtCenterZ.y, 0.0 ) + viewspaceDirZNormalized * (pixTZ - pixCenterPos.z);
float3 pixBDelta = float3( 0.0, +pixelDirRBViewspaceSizeAtCenterZ.y, 0.0 ) + viewspaceDirZNormalized * (pixBZ - pixCenterPos.z);

const float rangeReductionConst = 4.0f;
const float modifiedFalloffCalcMulSq = rangeReductionConst * falloffCalcMulSq;

float4 additionalObscurance;
additionalObscurance.x = CalculatePixelObscurance( pixelNormal, pixLDelta, modifiedFalloffCalcMulSq );
additionalObscurance.y = CalculatePixelObscurance( pixelNormal, pixRDelta, modifiedFalloffCalcMulSq );
additionalObscurance.z = CalculatePixelObscurance( pixelNormal, pixTDelta, modifiedFalloffCalcMulSq );
additionalObscurance.w = CalculatePixelObscurance( pixelNormal, pixBDelta, modifiedFalloffCalcMulSq );

obscuranceSum += u_params[14].z * dot( additionalObscurance, edgesLRTB );
}
}


if( !adaptiveBase && (qualityLevel >= (2) ) )
{
float3 neighbourNormalL = LoadNormal( int2(fullResCoord), int2( -2, 0 ) );
float3 neighbourNormalR = LoadNormal( int2(fullResCoord), int2( 2, 0 ) );
float3 neighbourNormalT = LoadNormal( int2(fullResCoord), int2( 0, -2 ) );
float3 neighbourNormalB = LoadNormal( int2(fullResCoord), int2( 0, 2 ) );

const float dotThreshold = (0.5);

float4 normalEdgesLRTB;
normalEdgesLRTB.x = saturate( (dot( pixelNormal, neighbourNormalL ) + dotThreshold ) );
normalEdgesLRTB.y = saturate( (dot( pixelNormal, neighbourNormalR ) + dotThreshold ) );
normalEdgesLRTB.z = saturate( (dot( pixelNormal, neighbourNormalT ) + dotThreshold ) );
normalEdgesLRTB.w = saturate( (dot( pixelNormal, neighbourNormalB ) + dotThreshold ) );



edgesLRTB *= normalEdgesLRTB;
}

const float globalMipOffset = (-4.3);
float mipOffset = ( qualityLevel < (2) ) ? ( 0 ) : ( log2( pixLookupRadiusMod ) + globalMipOffset );



float2 normXY = float2( pixelNormal.x, pixelNormal.y );
float normXYLength = length( normXY );
normXY /= float2( normXYLength, -normXYLength );
normXYLength *= (0.4);

const float3 negViewspaceDir = -normalize( pixCenterPos );


if( (qualityLevel != 3) || adaptiveBase )
{

for( uint i = 0; i < numberOfTaps; i++ )
{
SSAOTap( qualityLevel, obscuranceSum, weightSum, int(i), rotScale, pixCenterPos, negViewspaceDir, pixelNormal, normalizedScreenPos, mipOffset, falloffCalcMulSq, 1.0, normXY, normXYLength);
}
}
else
{

float2 fullResUV = normalizedScreenPos + u_params[3].zw.xy;
float importance = bgfxTexture2DLod(s_importanceMap, fullResUV, 0.0).x;


obscuranceSum *= (5 / float(32)) + (importance * (32-5) / float(32));


float2 baseValues = imageLoad(s_baseSSAO, int3( SVPosui, u_params[8].y ) ).xy;
weightSum += baseValues.y * (float(5) * 4.0);
obscuranceSum += (baseValues.x) * weightSum;


float edgeCount = dot( 1.0-edgesLRTB, float4( 1.0, 1.0, 1.0, 1.0 ) );


float avgTotalImportance = float(s_loadCounter[0]) * u_params[7].z;

float importanceLimiter = saturate( u_params[7].w / avgTotalImportance );
importance *= importanceLimiter;

float additionalSampleCountFlt = (32-5) * importance;

const float blendRange = 3.0;
const float blendRangeInv = 1.0 / blendRange;

additionalSampleCountFlt += 0.5;
uint additionalSamples = uint( additionalSampleCountFlt );
uint additionalSamplesTo = min( 32, additionalSamples + 5 );


[loop]
for( uint i = 5; i < additionalSamplesTo; i++ )
{
additionalSampleCountFlt -= 1.0f;
float weightMod = saturate(additionalSampleCountFlt * blendRangeInv);
SSAOTap( qualityLevel, obscuranceSum, weightSum, int(i), rotScale, pixCenterPos, negViewspaceDir, pixelNormal, normalizedScreenPos, mipOffset, falloffCalcMulSq, weightMod, normXY, normXYLength);
}
}


if( adaptiveBase )
{
float obscurance = obscuranceSum / weightSum;

outShadowTerm = obscurance;
outEdges = float4(0,0,0,0);
outWeight = weightSum;
return;
}


float obscurance = obscuranceSum / weightSum;


float fadeOut = saturate( pixCenterPos.z * u_params[6].x + u_params[6].y );


if( !adaptiveBase && (qualityLevel >= (1)) )
{



float edgeFadeoutFactor = saturate( (1.0 - edgesLRTB.x - edgesLRTB.y) * 0.35) + saturate( (1.0 - edgesLRTB.z - edgesLRTB.w) * 0.35 );




fadeOut *= saturate( 1.0 - edgeFadeoutFactor );
}





obscurance = u_params[5].y * obscurance;


obscurance = min( obscurance, u_params[5].w );


obscurance *= fadeOut;



float occlusion = 1.0 - obscurance;



occlusion = pow( saturate( occlusion ), u_params[5].z );


outShadowTerm = occlusion;
outEdges = edgesLRTB;
outWeight = weightSum;
}

[numthreads(8, 8, 1)]
void main( int3 gl_GlobalInvocationID : SV_DispatchThreadID )
{
uint2 dtID = uint2(gl_GlobalInvocationID.xy) + uint2(u_rect.xy);
if (all(lessThan(dtID.xy, u_rect.zw) ) )
{
float outShadowTerm;
float outWeight;
float4 outEdges;
GenerateSSAOShadowsInternal( outShadowTerm, outEdges, outWeight, float2(dtID.xy), 3, true);
float2 out0;
out0.x = outShadowTerm;

if ( true )
{
out0.y = outWeight / (float(5) * 4.0);
}
else
{
if (3 == 0)
out0.y = PackEdges( float4( 1, 1, 1, 1 ) );
else
out0.y = PackEdges( outEdges );
}
imageStore(s_target, int3(dtID.xy, u_params[14].w), out0.xyyy);
}
}

