#include "DK/stdafx.h"
#ifdef MAC
#include "DKMac.h"

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
    DKWARN("DKMac::GetUsername() not implemented yet");
    return false;
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
	return false;
}

bool DKMac::MiddleRelease(){
	//TODO
	return false;
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
	return false;
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
	return false;
}

bool DKMac::VirtualMemoryUsedByApp(unsigned int& virtualMemory){
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
    return false;
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
    return false;
}

bool DKMac::PhysicalMemoryUsed(unsigned long long& physicalMemory){
    //TODO
    /*
    #include <mach/vm_statistics.h>
    #include <mach/mach_types.h>
    #include <mach/mach_init.h>
    #include <mach/mach_host.h>
    
    int main(int argc, const char * argv[]) {
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
    return false;
}

bool DKMac::PhysicalMemoryUsedByApp(unsigned int& physicalMemory){
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
     return false;
}

bool DKMac::CpuInit(){
	//TODO
	return false;
}

bool DKMac::CpuUsed(int& cpu){
	//TODO
	return false;
}

bool DKMac::CpuUsedByApp(int& cpu){
	//TODO
	return false;
}

bool DKMac::TurnOffMonitor(){
	io_registry_entry_t r = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler");
	if(!r){ return false; }
	int err = IORegistryEntrySetCFProperty(r, CFSTR("IORequestIdle"), kCFBooleanTrue);
	IOObjectRelease(r);
	return true;
}

bool DKMac::TurnOnMonitor(){
	return false;
}

bool DKMac::LowPowerMonitor(){
	return false;
}

#endif //MAC