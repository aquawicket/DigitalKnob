/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#if MAC
#include "DK/DKMac.h"
#include "DK/DKUnix.h"

WARNING_DISABLE
#import "CoreFoundation/CoreFoundation.h"
#import "CoreGraphics/CoreGraphics.h"
WARNING_ENABLE

bool DKMac::GetKey(int& key){
    return DKUnix::GetKey(key);
}

bool DKMac::GetMousePos(int& x, int& y){
	CGEventRef ourEvent = CGEventCreate(NULL);
	CGPoint point = CGEventGetLocation(ourEvent);
	CFRelease(ourEvent);
	x = point.x;
	y = point.y;
	return true;
}

bool DKMac::SetMousePos(const int& x, const int& y){
	CGWarpMouseCursorPosition(CGPointMake(x, y));
	return true;
}

bool DKMac::GetScreenWidth(int& w){
	CGRect mainMonitor = CGDisplayBounds(CGMainDisplayID());
	CGFloat monitorWidth = CGRectGetWidth(mainMonitor);
	w = monitorWidth;
	return true;
}

bool DKMac::GetScreenHeight(int& h){
	CGRect mainMonitor = CGDisplayBounds(CGMainDisplayID());
	CGFloat monitorHeight = CGRectGetHeight(mainMonitor);
	h = monitorHeight;
	return true;
}

bool DKMac::GetUsername(DKString& username){
    return DKERROR("not implemented\n");
}

bool DKMac::LeftPress(){
    int x, y;
    GetMousePos(x, y);
    CGPoint point;
    point.x = x;
    point.y = y;
    CGEventRef eventRef = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseDown, point, kCGMouseButtonLeft);
	CGEventPost(kCGHIDEventTap, eventRef);
	CFRelease(eventRef);
	return true;
}

bool DKMac::LeftRelease(){
    int x, y;
    GetMousePos(x, y);
    CGPoint point;
    point.x = x;
    point.y = y;
	CGEventRef eventRef = CGEventCreateMouseEvent(NULL, kCGEventLeftMouseUp, point, kCGMouseButtonLeft);
	CGEventPost(kCGHIDEventTap, eventRef);
	CFRelease(eventRef);
	return true;
}

bool DKMac::RightPress(){
    int x, y;
    GetMousePos(x, y);
    CGPoint point;
    point.x = x;
    point.y = y;
	CGEventRef eventRef = CGEventCreateMouseEvent(NULL, kCGEventRightMouseDown ,point, kCGMouseButtonRight);
	CGEventPost(kCGHIDEventTap, eventRef);
	CFRelease(eventRef);
	return true;
}

bool DKMac::RightRelease(){
    int x, y;
    GetMousePos(x, y);
    CGPoint point;
    point.x = x;
    point.y = y;
	CGEventRef eventRef = CGEventCreateMouseEvent(NULL, kCGEventRightMouseUp, point, kCGMouseButtonRight);
	CGEventPost(kCGHIDEventTap, eventRef);
	CFRelease(eventRef);
	return true;
}

bool DKMac::MiddlePress(){
	//TODO
	return DKERROR("not implemented\n");
}

bool DKMac::MiddleRelease(){
	//TODO
	return DKERROR("not implemented\n");
}

bool DKMac::PressKey(int key){
	CGKeyCode keyCode = key;
	CGEventRef eventRef = CGEventCreateKeyboardEvent(NULL, keyCode, true);
	CGEventPost(kCGSessionEventTap, eventRef);
	CFRelease(eventRef);
	return true;
}

bool DKMac::ReleaseKey(int key){
	CGKeyCode keyCode = key;
	CGEventRef eventRef = CGEventCreateKeyboardEvent(NULL, keyCode, false);
	CGEventPost(kCGSessionEventTap, eventRef);
	CFRelease(eventRef);
	return true;
}

bool DKMac::VirtualMemory(unsigned long long& virtualMemory){
    //TODO
    /*
	struct statfs stats;
	if (0 == statfs("/", &stats))
	{
		virtualMemory = (uint64_t)stats.f_bsize * stats.f_bfree;
	}
    */
	return DKERROR("not implemented\n");
}

bool DKMac::VirtualMemoryUsed(unsigned long long& virtualMemory){
    //TODO
    /*
    xsw_usage vmusage = {0};
    size_t size = sizeof(vmusage);
    if( sysctlbyname("vm.swapusage", &vmusage, &size, NULL, 0)!=0 )
    {
        perror( "unable to get swap usage by calling sysctlbyname(\"vm.swapusage\",...)" );
    }
    */
	return DKERROR("not implemented\n");
}

bool DKMac::VirtualMemoryUsedByApp(unsigned long long& virtualMemory){
    //TODO
    /*
    #include<mach/mach.h>
    struct task_basic_info t_info;
    mach_msg_type_number_t t_info_count = TASK_BASIC_INFO_COUNT;
    if (KERN_SUCCESS != task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&t_info, &t_info_count)){
        return false;
    }
    // resident size is in t_info.resident_size;
    // virtual size is in t_info.virtual_size;
    virtualMemory = t_info.virtual_size;
    */
    return DKERROR("not implemented\n");
}

bool DKMac::PhysicalMemory(unsigned long long& physicalMemory){
    //TODO
    /*
    #include <sys/types.h>
    #include <sys/sysctl.h>
    int mib[2];
    int64_t physical_memory;
    mib[0] = CTL_HW;
    mib[1] = HW_MEMSIZE;
    int length = sizeof(int64_t);
    sysctl(mib, 2, &physical_memory, &length, NULL, 0);	return false;
    */
    return DKERROR("not implemented\n");
}

bool DKMac::PhysicalMemoryUsed(unsigned long long& physicalMemory){
    //TODO
    /*
    #include <mach/vm_statistics.h>
    #include <mach/mach_types.h>
    #include <mach/mach_init.h>
    #include <mach/mach_host.h>
    int main(int argc, const char * argv[]){
        vm_size_t page_size;
        mach_port_t mach_port;
        mach_msg_type_number_t count;
        vm_statistics64_data_t vm_stats;
        mach_port = mach_host_self();
        count = sizeof(vm_stats) / sizeof(natural_t);
        if (KERN_SUCCESS == host_page_size(mach_port, &page_size) &&
            KERN_SUCCESS == host_statistics64(mach_port, HOST_VM_INFO,
                                              (host_info64_t)&vm_stats, &count))
        {
            long long free_memory = (int64_t)vm_stats.free_count * (int64_t)page_size;
            long long used_memory = ((int64_t)vm_stats.active_count +
                                     (int64_t)vm_stats.inactive_count +
                                     (int64_t)vm_stats.wire_count) *  (int64_t)page_size;
            printf("free memory: %lld\nused memory: %lld\n", free_memory, used_memory);
        }
        return 0;
    }
    */
    return DKERROR("not implemented\n");
}

bool DKMac::PhysicalMemoryUsedByApp(unsigned long long& physicalMemory){
    //TODO
    /*
     #include<mach/mach.h>
     struct task_basic_info t_info;
     mach_msg_type_number_t t_info_count = TASK_BASIC_INFO_COUNT;
     if (KERN_SUCCESS != task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&t_info, &t_info_count)){
        return false;
     }
     // resident size is in t_info.resident_size;
     // virtual size is in t_info.virtual_size;
      physicalMemory = t_info.resident_size;
     */
     return DKERROR("not implemented\n");
}

bool DKMac::CpuInit(){
	//TODO
	return DKERROR("not implemented\n");
}

bool DKMac::CpuUsed(int& cpu){
	//TODO
	return DKERROR("not implemented\n");
}

bool DKMac::CpuUsedByApp(int& cpu){
	//TODO
	return DKERROR("not implemented\n");
}

bool DKMac::TurnOffMonitor(){
	io_registry_entry_t r = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
	if(!r) 
        return DKERROR("io_registry_entry_t invalid");
	int err = IORegistryEntrySetCFProperty(r, CFSTR("IORequestIdle"), kCFBooleanTrue);
    IOObjectRelease(r);
    switch (err){
        case 1:
            return DKERROR("KERN_INVALID_ADDRESS");
        case 2:
            return DKERROR("KERN_PROTECTION_FAILURE");
        case 3:
            return DKERROR("KERN_NO_SPACE");
        case 4:
            return DKERROR("KERN_INVALID_ARGUMENT");
        case 5:
            return DKERROR("KERN_FAILURE");
        case 6:
            return DKERROR("KERN_RESOURCE_SHORTAGE");
        case 7:
            return DKERROR("KERN_NOT_RECEIVER");
        case 8:
            return DKERROR("KERN_NO_ACCESS");
        case 9:
            return DKERROR("KERN_MEMORY_FAILURE");
        default:
            break;
    }
	return true;
}

bool DKMac::TurnOnMonitor(){
	return DKERROR("not implemented\n");
}

bool DKMac::LowPowerMonitor(){
	return DKERROR("not implemented\n");
}

#endif //MAC