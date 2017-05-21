#ifndef __GDT_H
#define __GDT_H

typedef struct {
	uint16_t limit_lo;
	uint16_t base_lo;
	uint8_t base_hi;
	uint8_t type;
	uint8_t flags_limit_hi;
	uint8_t base_vhi;
} SegmentDescriptor;

typedef struct{
	SegmentDescriptor null_segment;
	SegmentDescriptor unused_segment;
	SegmentDescriptor code_segment;
	SegmentDescriptor data_segment;
} GlobalDescriptorTable;


#endif //__GDT_H