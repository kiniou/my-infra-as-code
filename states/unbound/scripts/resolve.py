import re
import os.path

ip_matcher = re.compile(r'^(?P<ip_address>\d+\.\d+\.\d+\.\d+)')


def init(_id, cfg):
    return True


def deinit(_id):
    return True


def inform_super(_id, qstate, superqstate, qdata):
    return True


def get_ip(qstate):
    ip_address = None
    if not os.path.exists('/tmp/hosts.vagrant'):
        return ip_address

    with open('/tmp/hosts.vagrant', 'r') as f:
        data = [line.rstrip() for line in f.readlines()]
    entries = [entry for entry in data
               if qstate.qinfo.qname_str == entry.split()[1]]
    if entries:
        # TODO: find qname entry from data and set ip_address variable
        host_entry = next(iter(entries), "")
        ip_match = ip_matcher.match(host_entry)
        ip_address = (ip_match.group('ip_address')
                      if ip_match is not None else None)
    return ip_address


def operate(_id, event, qstate, qdata):
    log_info("Event: %s" % event)
    if event in [MODULE_EVENT_NEW, MODULE_EVENT_PASS]:
        msg = DNSMessage(qstate.qinfo.qname_str, RR_TYPE_A, RR_CLASS_IN, PKT_QR | PKT_RA | PKT_AA)
        ip_address = get_ip(qstate)

        if ip_address is not None:
            # append RR
            if (qstate.qinfo.qtype == RR_TYPE_A) or (qstate.qinfo.qtype == RR_TYPE_ANY):
                msg.answer.append("%s 10 IN A %s" % (qstate.qinfo.qname_str,
                                                     ip_address))

            # set qstate.return_msg
            if not msg.set_return_msg(qstate):
                qstate.ext_state[id] = MODULE_ERROR
                return True

            #we don't need validation, result is valid
            qstate.return_msg.rep.security = 2

            qstate.return_rcode = RCODE_NOERROR
            qstate.ext_state[_id] = MODULE_FINISHED
            return True

        # Pass on the unknown query to the iterator
        log_info("Could not find ip for %s in /tmp/hosts.vagrant" % (qstate.qinfo.qname_str))
        qstate.ext_state[_id] = MODULE_WAIT_MODULE
        return True

    if event == MODULE_EVENT_MODDONE:  # the iterator has finished
        # we don't need modify result
        log_info("Iterator is done: %s" % (qstate))
        qstate.ext_state[_id] = MODULE_FINISHED
        return True

    log_err("pythonmod: Unknown event")
    qstate.ext_state[_id] = MODULE_ERROR
    return True
